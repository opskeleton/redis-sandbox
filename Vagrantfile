# -*- mode: ruby -*-
# vi: set ft=ruby :
#
update = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak s/us.archive/il.archive/g /etc/apt/sources.list
  sudo aptitude update 
  touch /tmp/up
fi
SCRIPT


Vagrant.configure("2") do |config|

  device = ENV['VAGRANT_BRIDGE'] || 'eth0'

  config.vm.define :ubuntu, primary: true do |ubuntu|
    ubuntu.vm.box = 'ubuntu-15.04_puppet-3.8.2' 
    ubuntu.vm.network :public_network, :bridge => device, :dev => device
    ubuntu.vm.hostname = 'ubuntu-redis.local'
    ubuntu.vm.provider 'libvirt'

    ubuntu.vm.provider :virtualbox do |vb,override|
	override.vm.network :forwarded_port, guest: 6379, host: 6379
	vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    ubuntu.vm.provider :libvirt do |domain, override|
	override.vm.network :forwarded_port, guest: 6379, host: 6379
	domain.uri = 'qemu+unix:///system'
	domain.host = "redis.local"
	domain.memory = 2048
	domain.cpus = 2
	override.vm.synced_folder './', '/vagrant', type: 'nfs'
    end


    ubuntu.vm.provision :shell, :inline => update
    ubuntu.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = '--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml'
    end
  end

  config.vm.define :centos do |centos|
    centos.vm.box = 'vStone/centos-7.x-puppet.3.x' 
    centos.vm.network :public_network, :bridge => device, :dev => device
    centos.vm.hostname = 'centos-redis.local'
    centos.vm.network :forwarded_port, guest: 6379, host: 6380
    centos.vm.network :private_network, ip: "192.168.1.26"

    centos.vm.provider :virtualbox do |vb|
	vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    centos.vm.provider :libvirt do |domain|
	domain.uri = 'qemu+unix:///system'
	domain.host = "redis.local"
	domain.memory = 2048
	domain.cpus = 2
    end

    centos.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = '--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml'
    end
  end
end
