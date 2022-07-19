# vagrant-c7-pg13-pg13 - vagrant two node pg13 cluster with master-slave replication

## Getting started - how does the replication work

### 1)  Extra config settings on master 

These /24 trust settings are very generous but okay for 
```
~/projects/vagrant-c7-pg13-pg13 $ grep replication master/pg_hba.conf |grep -v '#'
host    replication     postgres        192.168.60.0/24          trust
host    replication     rep             192.168.60.0/24          trust
```

We need to specify at least 2 max_wal_senders
```
~/projects/vagrant-c7-pg13-pg13 $ grep max_wal_senders master/postgresql.conf 
max_wal_senders = 2		# max number of walsender processes
```

### 2) On the master, run initdb and standard pgbench

```
~/projects/vagrant-c7-pg13-pg13 $ grep 'initdb\|bench' master.sh 
/usr/pgsql-13/bin/postgresql-13-setup initdb
# setup bench1 linux user
adduser bench1
# setup bench1 postgres user and database
su -c "createuser bench1" -s /bin/sh postgres
su -c "createdb bench1"  -s /bin/sh postgres
su -c "/usr/pgsql-13/bin/pgbench -i -s 30" -s /bin/sh bench1
```


### 3) on the slave, we don't run initdb, instead we run 

```
~/projects/vagrant-c7-pg13-pg13 $ grep pg_basebackup slave.sh
pg_basebackup -h 192.168.60.5 -D /var/lib/pgsql/13/data -U rep -v -P --wal-method=stream -R
```

which will both copy the base backup and also start the replication going... 



## Other notes (optional further tests)
* [Initial Setup - based setup with two connected centos7 nodes - both with pg13 installed](docs/initial_setup.md)
* [Initial Setup - notes on adding ssh keys manually](docs/initial_setup-adding_ssh_keys_manually.md)


