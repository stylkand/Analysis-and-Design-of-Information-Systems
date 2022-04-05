#1) Set VMs on Okeanos and network 

#Set hostnames per host:
  sudo hostname mdw   #master
  sudo hostname sdw1  #host1
  sudo hostname sdw2  #host2

  sudo vim /etc/hosts  #on every host

#hosts file contains:

192.168.0.1 mdw
192.168.0.2 sdw1
192.168.0.3 sdw2


#2) Setting the Greenplum Recommended OS Parameters on every host 

#Set the following parameters in the /etc/sysctl.conf file and reboot:

kernel.shmall = 3800842
kernel.shmmax = 15568248832
kernel.shmmni = 4096
vm.overcommit_memory = 2
vm.overcommit_ratio = 95

net.ipv4.ip_local_port_range = 32768 60999

kernel.sem = 250 2048000 200 8192
kernel.sysrq = 1
kernel.core_uses_pid = 1
kernel.msgmnb = 65536
kernel.msgmax = 65536
kernel.msgmni = 2048

net.ipv4.tcp_syncookies = 1
net.ipv4.conf.default.accept_source_route = 0
net.ipv4.tcp_max_syn_backlog = 4096
net.ipv4.conf.all.arp_filter = 1
net.core.netdev_max_backlog = 10000
net.core.rmem_max = 2097152
net.core.wmem_max = 2097152

vm.swappiness = 10
vm.zone_reclaim_mode = 0
vm.dirty_expire_centisecs = 500
vm.dirty_writeback_centisecs = 100
vm.dirty_background_ratio = 0
vm.dirty_ratio = 0
vm.dirty_background_bytes = 1610612736
vm.dirty_bytes = 4294967296
vm.oom-kill = 0
vm.min_free_kbytes = 251658


#Set the following parameters in the /etc/security/limits.conf file:

* soft nofile 65536
* hard nofile 65536
* soft nproc 131072
* hard nproc 131072

#Set the following authentication parameters:

sudo nano /etc/ssh/sshd_config

PermitRootLogin yes
PasswordAuthentication yes

#3) Installing the Greenplum binaries on the master host 

#Add the Greenplum PPA repository to our Ubuntu System:

sudo apt update
sudo apt install software-properties-common
sudo add-apt-repository ppa:greenplum/db  

# https://launchpad.net/~greenplum/+archive/ubuntu/db?field.series_filter=xenial

#Update your Ubuntu system to retrieve information from the recently added repository:

sudo apt update

#Install the latest Greenplum Database release:

sudo apt install greenplum-db-5        #(Ubuntu Xenial needs gpdb 5)


#Create gpadmin user:

groupadd gpadmin
useradd gpadmin -r -m -g gpadmin
passwd gpadmin

#Establish ssh connection between hosts:
su gpadmin
ssh-keygen -t rsa -b 4096

#Source the path file from our master host’s Greenplum Database installation directory:
source /opt/gpdb/greenplum_path.sh

#Create a file called hostfile_exkeys that has the machine configured host names and host addresses (interface names) for each host in your Greenplum system (master, segments). 

#mdw
#sdw1
#sdw2

#Run gpssh command to enable passordless ssh for gpadmin user:	
gpssh-exkeys -f hostfile_exkeys


#4) Installing and Configuring Greenplum on all Hosts

#Log in to the master host as root:
sudo -i

#Run the gpseginstall utility referencing the hostfile_exkeys file we just created. 

gpseginstall -f hostfile_exkeys


#5) Confirming Our Installation 

#Log in as gpadmin:
su - gpadmin

source /opt/gpdb/greenplum_path.sh

#check if we can login to all hosts without a password prompt:
gpssh -f hostfile_exkeys -e ls -l  GPHOME

#6) Create data storages 

#Create directory:
mkdir -p /data/master
chown gpadmin /data/master

source /opt/gpdb/greenplum_path.sh 

#Copy directory to hosts:
gpssh -h sdw1 -e 'mkdir -p /data/master'
gpssh -h sdw2 -e 'chown gpadmin /data/master'


#7) Clone TPC-DS repository    https://github.com/greenbeam2002/TPC-DS-1

#download tarball file:

ssh root@mdw
mkdir -p /dsbenchmark
cd /dsbenchmark
curl -LO https://github.com/pivotal/TPC-DS/archive/refs/tags/v3.0.0.tar.gz
tar xzf v3.0.0.tar.gz
mv TPC-DS-3.0.0 TPC-DS


#8) Fix all dependencies and add special bash code in order to fit our requirements 


#Change 2 parameters of the tpcds_variables.sh file:

GEN_DATA_SCALE= 1
GEN_DATA_SCALE= 10 


RANDOM_DISTRIBUTION="true"  
RANDOM_DISTRIBUTION="false"

#9) Run TPC-DS and save results 

cd /dsbenchmark/TPC-DS
./tpcds.sh


#Libraries added to Ubuntu systems:

sudo apt install zlib
sudo apt-get install python3
sudo apt-get install libapr1
sudo apt-get install zlib1g