#!/bin/bash

source /vagrant/provision_base.sh

echo "The master-only steps"

/usr/pgsql-13/bin/postgresql-13-setup initdb
systemctl enable postgresql-13.service
systemctl start postgresql-13.service 


# setup bench1 linux user
adduser bench1
# setup bench1 postgres user and database
su -c "createuser bench1" -s /bin/sh postgres
su -c "createdb bench1"  -s /bin/sh postgres
# setup vagrant postgres user and database
su -c "createuser vagrant" -s /bin/sh postgres
su -c "createdb vagrant"  -s /bin/sh postgres

# initial data load for 
su -c "/usr/pgsql-13/bin/pgbench -i -s 30" -s /bin/sh bench1
su -c "/usr/pgsql-13/bin/pgbench -i -s 3" -s /bin/sh vagrant


sudo -u postgres -H sh -c "psql -c 'CREATE USER rep REPLICATION LOGIN CONNECTION LIMIT 2;'"

cp /vagrant/master/pg_hba.conf     /database/pg_hba.conf
cp /vagrant/master/postgresql.conf /database/postgresql.conf

chown postgres:postgres /database/pg_hba.conf
chown postgres:postgres /database/postgresql.conf

systemctl restart postgresql-13.service 

