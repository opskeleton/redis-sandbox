# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant::Config.run do |config|

  config.vm.define :redis do |redis|
    redis.vm.box = 'ubuntu-12.10_puppet-3'
    redis.vm.network :bridged
    redis.vm.customize ['modifyvm', :id, '--memory', 2048, '--cpus', 4]
    redis.vm.host_name = 'redis'
    redis.vm.provision :puppet, :options => ["--modulepath=/vagrant/modules:/vagrant/static-modules"]
  end

end
