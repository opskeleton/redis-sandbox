# -*- mode: ruby -*-
# vi: set ft=ruby :
#

Vagrant.configure("2") do |config|

    config.vm.box = 'ubuntu-16.04_puppet-3.8.7'
    config.vm.network :private_network, ip: '192.168.1.200'
    config.vm.hostname = 'redis.local'
    config.vm.network :forwarded_port, guest: 6379, host: 6379

end
