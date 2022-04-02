# <b> Greenplum performance Analysis </b>

### A semester project for Analysis and Design of Information Systems course at [ECE](https://www.ece.ntua.gr/en)⚡, [NTUA](https://www.ntua.gr/en)🎓, academic year 2021-2022
<img alt="Ubuntu Server" src = "https://img.shields.io/badge/Ubuntu Server-E95420?style=for-the-badge&logo=ubuntu&logoColor=white" height="28"> <img alt="Greenplum" src = "https://img.shields.io/badge/Greenplum-brightgreen?style=for-the-badge&logo=appveyor&logoColor=white" height="28">


The purpose of this assignment is to do performance Analysis to the *Greenplum Database*.

## 📋**Description**

*Greenplum* is an open source parallel data platform for analytics, machine learning and AI.
As a MPP (Massive Parallel Processing) database, data is partitioned across multiple servers so processing happens faster.

In order to run benchmarks on our platform we created 4 Virtual Machines ( 1 master, 3 segments ) granted by *Okeanos* cloud service.
Benchmark used to accomplish this task is the TPC-DS standard linked [here](https://www.tpc.org/tpcds/default5.asp) .


**Specifications per VM**

|OS | CPUs |RAM |Disk space| Gpdb version |  
|----|-----|-------| ------| ------------ |  
|Ubuntu 16.04 LTS (Xenial)| 4 | 8GB|30GB| 5.28.5 |

The commited report file contains:
- generic information about Greenplum database (pros and cons)
- link to [source code](https://docs.google.com/document/d/1HoePsA3QQi8bwelvjqMu88w0YKiHD8EwspXp10J1Rls/edit)
- link to final [results](https://docs.google.com/document/d/1leDGlIEYOeVTWbKZoUeB-EuLQC_FzSqHvJS26zKc-5Q/edit)
- conclusions about the efficiency of Greenplum parallel processing 

