#! /bin/bash
if [ ! -f /home/vagrant/already-installed-flag ]
then
  echo 'nameserver 8.8.8.8' >> /etc/resolv.conf
  echo "ADD EXTRA ALIAS VIA .bashrc"
  echo 'export PATH="$PATH:/usr/pgsql-13/bin"' >> /vagrant/bashrc.append.txt
  cat /vagrant/bashrc.append.txt >> /home/vagrant/.bashrc
  cat /vagrant/bashrc.append.txt >> /root/.bashrc 
  echo "alias pg='sudo su - postgres'" >> /home/vagrant/.bashrc
  echo "alias bench='sudo su - bench1'" >> /home/vagrant/.bashrc


  #echo "GENERAL YUM UPDATE"
  #yum -y update
  #echo "INSTALL GIT"


  # Regular pg13 install                                                                           
  # As of 15 April 2019, there is only one repository RPM per distro, and it includes repository information for all available PostgreSQL releases.
  # rpm -ivh https://yum.postgresql.org/9.6/redhat/rhel-7.3-x86_64/pgdg-redhat-repo-latest.noarch.rpm
  # rpm -Uvh https://yum.postgresql.org/13/redhat/rhel-7-x86_64/pgdg-centos13-13-2.noarch.rpm
  # https://yum.postgresql.org/repopackages/
  rpm -ivh https://download.postgresql.org/pub/repos/yum/reporpms/EL-7-x86_64/pgdg-redhat-repo-latest.noarch.rpm

  yum -y update
  yum -y install postgresql13-server postgresql13
  yum -y install postgresql13-contrib postgresql13-libs postgresql13-devel

  cp /vagrant/bashrc.append.txt /tmp/bashrc.append.txt
  su -c "cat /tmp/bashrc.append.txt >> ~/.bash_profile" -s /bin/sh postgres
 
  # Extra packages and devtool for install of https://github.com/ossc-db/pg_plan_advsr  
  #yum -y install postgresql-devel
  #yum -y install gcc
  
  # prevent vagrant user ssh warning "setlocale: LC_CTYPE: cannot change locale (UTF-8): No such file or directory"
  sudo cat /vagrant/environment >> /etc/environment

  # nice setup shortcut as per https://github.com/philmcc/postgres_clusters
  ln -s /var/lib/pgsql/13/data /database
  cd /database



else
  echo "already installed flag set : /home/vagrant/already-installed-flag"
fi

