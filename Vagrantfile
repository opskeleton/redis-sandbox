# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  bridge = ENV['VAGRANT_BRIDGE']
  bridge ||= 'eth0'

  config.vm.define :ubuntu do |ubuntu|
    ubuntu.vm.box = 'ubuntu-13.04_puppet-3.3.1' 
    ubuntu.vm.network :public_network, :bridge => bridge
    ubuntu.vm.hostname = 'ubunt-redis.local'
    ubuntu.vm.network :forwarded_port, guest: 6379, host: 6379
    ubuntu.vm.network :private_network, ip: "192.168.1.25"

    ubuntu.vm.provider :virtualbox do |vb|
	vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
    end

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

    centos.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = '--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml'
    end
  end
end
