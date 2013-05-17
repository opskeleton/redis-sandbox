# -*- mode: ruby -*-
# vi: set ft=ruby :
Vagrant.configure("2") do |config|

  config.vm.box = 'ubuntu-12.10_puppet-3.1' 
  config.vm.network :public_network
  config.vm.hostname = 'redis.local'
  config.vm.network :forwarded_port, guest: 6379, host: 6379
  config.vm.network :private_network, ip: "192.168.1.25"

  config.vm.provider :virtualbox do |vb|
    vb.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 2]
  end

  config.vm.provision :puppet do |puppet|
    puppet.manifests_path = 'manifests'
    puppet.manifest_file  = 'default.pp'
    puppet.options = '--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml'
  end

end
