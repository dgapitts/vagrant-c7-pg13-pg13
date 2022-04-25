#!/bin/bash

source /vagrant/provision.sh

echo "The master-only steps"

/usr/pgsql-13/bin/postgresql-13-setup initdb
systemctl enable postgresql-13.service
systemctl start postgresql-13.service 



sudo -u postgres -H sh -c "psql -c 'CREATE USER rep REPLICATION LOGIN CONNECTION LIMIT 2;'"

cp /vagrant/master/pg_hba.conf     /database/pg_hba.conf
cp /vagrant/master/postgresql.conf /database/postgresql.conf

chown postgres:postgres /database/pg_hba.conf
chown postgres:postgres /database/postgresql.conf

systemctl restart postgresql-13.service 

