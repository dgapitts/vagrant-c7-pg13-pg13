# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|
  config.ssh.insert_key = false
  config.vm.provider :virtualbox do |vb|
    vb.customize ["modifyvm", :id, "--memory", "512"]
  end

# Database server 1.
config.vm.define "db1" do |db|
  db.vm.hostname = "pg13-db1.dev"
  db.vm.box = "https://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1804_02.VirtualBox.box"
  db.vm.network :private_network, ip: "192.168.60.5"
  db.vm.provision :shell, :path => "master.sh"
end

# Database server 2.
config.vm.define "db2" do |db|
  db.vm.hostname = "pg13-db2.dev"
  db.vm.box = "https://cloud.centos.org/centos/7/vagrant/x86_64/images/CentOS-7-x86_64-Vagrant-1804_02.VirtualBox.box"
  db.vm.network :private_network, ip: "192.168.60.6"
  db.vm.provision :shell, :path => "provision.sh"
end

end

