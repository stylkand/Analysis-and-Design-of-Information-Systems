# Analysis-and-Design-of-Information-Systems
The purpose of this assignment is to do performance Analysis to the *Greenplum Database*.

*Greenplum* is an open source parallel data platform for analytics, machine learning and AI.
As a MPP (Massive Parallel Processing) database, data is partitioned across multiple servers so processing happens faster.

In order to run benchmarks on our platform we created 4 Virtual Machines ( 1 master, 3 segments ) granted by *Okeanos* cloud service.
Benchmark used to accomplish this task is the TPC-DS standard linked [here](https://www.tpc.org/tpcds/default5.asp) .


**Configurations per VM**

|OS | CPUs |RAM |Disk space| Gpdb version |  
|----|-----|-------| ------| ------------ |  
|Ubuntu 16.04 LTS (Xenial)| 4 | 8GB|30GB| 5.28.5 |
