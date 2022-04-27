#!/bin/bash

source /vagrant/provision_base.sh

echo "The slave-only steps"


pg_basebackup -h 192.168.60.5 -D /var/lib/pgsql/13/data -U rep -v -P --wal-method=stream -R
# echo "trigger_file = '/tmp/postgresql.trigger.5432'" >> /database/recovery.conf

chown postgres:postgres -R /var/lib/pgsql/13/data

systemctl enable postgresql-13.service
systemctl start postgresql-13.service 

#cp /vagrant/master/pg_hba.conf     /database/pg_hba.conf
#cp /vagrant/master/postgresql.conf /database/postgresql.conf

#chown postgres:postgres /database/pg_hba.conf
#chown postgres:postgres /database/postgresql.conf

systemctl restart postgresql-13.service 

