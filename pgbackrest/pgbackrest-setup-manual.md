# PgBackRest Setup with Patroni Cluster

|Author: | MD OBAIDUL HAQUE SARKER |    
|:-----------|:-------------------------|
| Email:    | aupo37@gmail.com         |
| LinkedIn: | https://www.linkedin.com/in/md-obaidul-haque-sarker-5b983b26 |
| Github: | https://github.com/obaidulsarker |
| Created On: | 04-May-2025 |
| Updated On: | 05-May-2025 |

## 1.	Introduction
In a high-availability PostgreSQL environment managed by Patroni, robust backup and recovery strategies are essential. pgBackrest is a powerful and reliable backup and restore solution specifically designed for PostgreSQL. It addresses the limitations of traditional tools like pg_dump and tar by offering features like incremental backups, parallel processing, and efficient WAL (Write-Ahead Log) management. Integrating pgBackrest with Patroni ensures that backups are consistent and can be performed without disrupting database operations, thus minimizing downtime and data loss.

## 2.	Deployment Architecture

