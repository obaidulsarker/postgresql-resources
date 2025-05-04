# PostgreSQL HA Cluster Setup Using Patroni

| Author:   | MD OBAIDUL HAQUE SARKER |    
| -----------|-------------------------|
| Email:    | aupo37@gmailcom         |
| LinkedIn: | https://www.linkedin.com/in/md-obaidul-haque-sarker-5b983b26 |
| Github: | https://github.com/obaidulsarker |


## 1.	Introduction

Patroni is a cluster manager that can customize and automate the deployment and maintenance of PostgreSQL HA (High Availability) clusters. It ensures that PostgreSQL databases remain operational and resilient to failures. Patroni works by utilizing a distributed consensus mechanism to manage the configuration and state of a PostgreSQL cluster, facilitating automatic failover in case of primary node failures.

## 2. Deployment Architecture

<img title="Patroni Architecture Diagram" alt="Alt text" src="Patroni_Architecture_Diagram.jpg">
<center>Figure: Deployment diagram of Patroni cluster</center>
</br> </br>
<strong> ETCD </strong> is a strongly consistent, distributed key-value store that provides a reliable way to store data that a distributed system or cluster of machines needs to access. Use Etcd to store the state of the PostgreSQL cluster to keep the Postgres cluster up and running.
</br> </br>
<strong> HAProxy </strong> or a load balancer offers load balancing and proxying for TCP and HTTP-based applications.
</br> </br>
<strong> PgBackRest </strong> is robust tool used for backup and recovery processes.

### Server Information
| Host Name|	IP Address|	OS	| Purpose |
|---------| ----------| ------| ----------|
| node1 |	192.168.17.133 |	AlmaLinux 9.5	| PostgreSQL, ETCD, Patroni |
| node2	| 192.168.17.134	| AlmaLinux 9.5 |	PostgreSQL, ETCD, Patroni |
| node3 |	192.168.17.135 |	AlmaLinux 9.5	| PostgreSQL, ETCD, Patroni |
| haproxy |	192.168.17.136 |	AlmaLinux 9.5 |	Database load balancing | 
| pgbackrest |	192.168.17.137 |	AlmaLinux 9.5 |	Backup and recovery tool |

### Port Information
| Service Name | version |	Port |	Purpose |
|-------------- | ------|-------- |-----------|
| ETCD |	3.5 |2379, 2380 |	2379 = Etcd client communication </br> 2380 = Etcd peer-to-peer communication (cluster members)  |
| Patroni REST API | 4.0 |	8008 |	REST API used by Patroni for health checks, failover, etc. |
| PostgreSQL | 17.0 |	5432 |	Main PostgreSQL database port |
| HAProxy	| 2.4 |5000, 5001 |	5000 = Client connection for read/write </br> 5001 = Client connection for read-only |

## 3.	Installation
### 3.1	Pre-requisites
- On all servers, disable the SELinux and firewall.</br>
  ```
  vi /etc/selinux/config
  ```
| SELINUX=disabled |
|------------------|

Press :x to save the file.

```
sudo systemctl stop firewalld  
sudo systemctl disable firewalld
reboot now
```
- On all servers, update the hostname according to below information.</br>
In 192.168.17.133 server,
```
vi /etc/hosts
```
</br>

```
192.168.17.133 node1 
192.168.17.134 node2  
192.168.17.135 node3  
192.168.17.136 haproxy  
192.168.17.137 pgbackrest
```
*** Repeat above step on all servers to change the hostname.

### Install PostgreSQL on all of servers except haproxy without initializing the database.
- Install the repository RPM.
  ```
  sudo dnf install -y https://download.postgresql.org/pub/repos/yum/reporpms/EL-9-x86_64/pgdg-redhat-repo-latest.noarch.rpm
  ```
- Disable the built-in PostgreSQL module.
  ```
  sudo dnf -qy module disable postgresql
  ```
- Install PostgreSQL.
  ```
  sudo dnf install -y postgresql17-server postgresql17-contrib
  ```

### Activate SSH trust among nodes using postgres user.
- For example, SSH trust from node1 to node2, node3 and pgbackrest servers.
  - Set postgres user ssh password.
    ```
    sudo passwd postgres
    ```
    Remember postgres system passowrd.
    
  - Generate SSH keys on all nodes with postgres user.
    ```
    su - postgres
    ssh-keygen
    ```
  - Copy SSH keys from source to destination servers. For example, copy ssh public key from node1 to node2, node3 and pgbackrest servers.
   ```
    ssh-copy-id postgres@node2
    ssh-copy-id postgres@node3
    ssh-copy-id postgres@pgbackrest
  ```
   *** Repeat above step for other servers.

### Install and Configure the ETCD cluster
#### Setup ETCD on node1, node2 and node3 nodes and follow the steps outlined below.
```
wget https://github.com/etcd-io/etcd/releases/download/v3.5.0/etcd-v3.5.0-linux-amd64.tar.gz
dnf install -y tar
tar -xvf etcd-v3.5.0-linux-amd64.tar.gz
ls -la
cd etcd-v3.5.0-linux-amd64
ls -la
```
- Copy etcdctl binary to /usr/bin directory.
  ```
  cp etcd etcdctl etcdutl /usr/bin
  ```
- Create an etcd user and group specifically for running etcd binaries.
  ```
  groupadd --system etcd
  useradd -s /bin/bash --system -g etcd etcd
  ```
- Create data and configuration directories, and give permission on created directories.
  ```
  sudo mkdir -p /var/lib/etcd/
  sudo mkdir /etc/etcd
  sudo chown -R etcd:etcd /var/lib/etcd/
  sudo chown -R etcd:etcd  /etc/etcd
  chmod 0775 /var/lib/etcd/
  ```
  
- Add environment variables on node1 server.
  ```
  vi .bash_profile
  ```
  </br>
  
  ```
  ETCDCTL_API=3
  NODE1=192.168.17.133
  NODE2=192.168.17.134
  NODE3=192.168.17.135
  
  ENDPOINTS=$NODE1:2379,$NODE2:2379,$NODE3:2379
  PATRONI_CONFIG_LOCATION=/etc/patroni/patroni.yml
  ```
  
  
  
  

  
    




