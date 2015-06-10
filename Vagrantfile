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

  bridge = ENV['VAGRANT_BRIDGE']
  bridge ||= 'eth0'

  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.box = 'ubuntu-14.10_puppet-3.7.3' 
    ubuntu.vm.network :public_network, :bridge => bridge
    ubuntu.vm.hostname = 'ubuntu-redis.local'

    ubuntu.vm.provider :virtualbox do |vb,override|
	override.vm.network :private_network, ip: '192.168.2.25'
	override.vm.network :forwarded_port, guest: 6379, host: 6379
	vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

    ubuntu.vm.provider :libvirt do |domain, override|
	override.vm.network :private_network, ip: '192.168.1.25'
	override.vm.network :forwarded_port, guest: 6379, host: 6379
	domain.uri = 'qemu+unix:///system'
	domain.host = "redis.local"
	domain.memory = 2048
	domain.cpus = 2
    end


    ubuntu.vm.provision :shell, :inline => update
    ubuntu.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = '--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml'
    end
  end

  config.vm.define :centos do |centos|
    centos.vm.box = 'centos-6.3_puppet_3' 
    centos.vm.network :public_network, :bridge => bridge
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
