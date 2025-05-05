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

<img title="PgBackRest Deployment Architecture Diagram" alt="Alt text" src="images/PgBackRest_Archietcure_Diagram.jpg">
<center>Figure: Deployment diagram of PgBackRest</center>
</br></br>

- <strong>PostgreSQL Servers:</strong> The Patroni cluster nodes running the PostgreSQL database.
- <strong>Backup Repository:</strong> A dedicated storage location for pgBackrest backups. This can be either a network file system (NFS) or separate disk storage on a dedicated server.
- <strong>pgBackrest:</strong> Installed on each PostgreSQL node and potentially on a dedicated backup server.
- <strong>Patroni:</strong> Manages the PostgreSQL cluster and ensures high availability.

### Server Information
| Host Name|	IP Address|	OS	| Purpose |
|---------| ----------| ------| ----------|
| node1 |	192.168.17.133 |	AlmaLinux 9.5	| PostgreSQL, ETCD, Patroni, pgbackrest |
| node2	| 192.168.17.134	| AlmaLinux 9.5 |	PostgreSQL, ETCD, Patroni, pgbackrest |
| node3 |	192.168.17.135 |	AlmaLinux 9.5	| PostgreSQL, ETCD, Patroni, pgbackrest |
| pgbackrest |	192.168.17.137 |	AlmaLinux 9.5 |	pgbackrest |

## 3.	Backup Strategy
|Backup Method|	Backup Type|	Frequency| 	Retention Policy|	RTO|	RPO|
|-------------|-------------|-----------|-------------------|----|----|
|pgBackrest| 	Full	|Weekly|	4 backups|	30 minutes|	10 minutes|
|pgBackrest| 	Incremental|	Daily|	28 days|	30 minutes|	10 minutes|
|pgBackrest| 	WAL archive|	Continuous|	28 days|	30 minutes|	10 minutes|

  - RTO (Recovery Time Objective)
  - RPO (Recovery Point Objective)</br>
  *** Assume that database size less is than 10GB.

## 4.	Installation and Configuration
### 3.1	Pre-requisites
  - Installed and configured the 3 nodes Patroni cluster.
  - Patroni cluster must be running.
  - A backup repository location with sufficient storage on dedicated backup server.
  - Network connectivity between Patroni nodes and the backup repository.
  - Update /etc/hosts on all servers.
  ```
  vi /etc/hosts
  ```
  ```
  192.168.17.133 node1
  192.168.17.134 node2
  192.168.17.135 node3
  192.168.17.137 pgbackrest 
  ```

 - #### Create postgres user on pgbackrest server.
   ```
   useradd postgres 
   passwd postgres 
   echo "postgres ALL=(ALL) NOPASSWD:ALL" >> /etc/sudoers
    ```
- #### Enable SSH trust among pgbackrest and all nodes of patroni cluster using postgres user.

  - On pgbackrest node, enable password less SSH authentication to all of patroni nodes.
    ```
    su – postgres
    ssh-keygen
    ssh-copy-id postgres@node1
    ssh-copy-id postgres@node2
    ssh-copy-id postgres@node3
    ```
  - On node1 of patroni cluster, enable password less SSH authentication to pgbackrest server.
    ```
    su – postgres
    ssh-copy-id postgres@pgbackrest
    ```
  - On node2 of patroni cluster, enable password less SSH authentication to pgbackrest server.
    ```
    su – postgres
    ssh-copy-id postgres@pgbackrest
    ```
  - On node3 of patroni cluster, enable password less SSH authentication to pgbackrest server.
    ```
    su – postgres
    ssh-copy-id postgres@pgbackrest
    ```
  - ### Install and Configure the PgBackRest

      - Install pgbackrest on all servers [pgbackrest, node1, node2 and node3].
        ```
        sudo dnf install -y epel-release
        sudo dnf install pgbackrest -y
        ```
      - Take backup existing config file [/etc/pgbackrest.conf] if any, on all servers [pgbackrest, node1, node2 and node3].
        ```
        mv etc/pgbackrest.conf etc/pgbackrest.conf.bk
        ```
      - Create following directories on all patroni nodes [node1, node2 and node3].
        ```
        sudo mkdir -p -m 770 /var/log/pgbackrest
        sudo chown postgres:postgres /var/log/pgbackrest
        sudo mkdir -p /etc/pgbackrest
        sudo mkdir -p /etc/pgbackrest/conf.d
        sudo touch /etc/pgbackrest/pgbackrest.conf
        sudo chmod 640 /etc/pgbackrest/pgbackrest.conf
        sudo chown postgres:postgres /etc/pgbackrest/pgbackrest.conf
        ```
        
      - Create following directories on pgabckrest server.
        ```
        sudo mkdir -p /data/pgbackrest
        sudo mkdir -p /var/log/pgbackrest
        sudo chown postgres:postgres /data/pgbackrest
        sudo chown postgres:postgres /var/log/pgbackrest
        sudo chmod 750 /data/pgbackrest
        sudo mkdir -p /etc/pgbackrest
        sudo mkdir -p /etc/pgbackrest/conf.d
        sudo touch /etc/pgbackrest/pgbackrest.conf
        sudo chmod 640 /etc/pgbackrest/pgbackrest.conf
        sudo chown postgres:postgres /etc/pgbackrest/pgbackrest.conf
        ```
    - Add following PostgreSQL parameters in /etc/patroni/patroni.yml on node1, node2 and node3 servers
      ```
      vi /etc/patroni/patroni.yml
      ```
      ```
      archive_command: "pgbackrest --stanza=patroni_backup archive-push %p"
      archive_mode: "on"
      wal_level: “replica”
      max_wal_senders: “10”
      restore_command: "pgbackrest --stanza=patroni_backup archive-get %f \"%p\""
      ```
      Here, stanza name is “patroni_backup”.
      <img title="Patroni Configuration" alt="Alt text" src="images/patroni_config.jpg">



