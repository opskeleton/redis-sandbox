# -*- mode: ruby -*-
# vi: set ft=ruby :
#
MIRROR=ENV['MIRROR'] || 'us.archive.ubuntu.com'

update_ubuntu = <<SCRIPT
if [ ! -f /tmp/up ]; then
  sudo sed -i.bak "s/us.archive.ubuntu.com/#{MIRROR}/g" /etc/apt/sources.list
  sudo sed -i.bak '/deb-src/d' /etc/apt/sources.list
  sudo apt-get update
  touch /tmp/up
fi
SCRIPT


Vagrant.configure("2") do |config|

  device = ENV['VAGRANT_BRIDGE'] || 'eth0'

  config.vm.define :ubuntu, primary: true do |ubuntu|
    ubuntu.vm.network :private_network, ip: '192.168.1.200'
    ubuntu.vm.box = 'ubuntu-16.04_puppet-3.8.7'
    ubuntu.vm.provider 'libvirt'

    ubuntu.vm.provider :libvirt do |domain, override|
	domain.uri = 'qemu+unix:///system'
	domain.host = "redis.local"
	domain.memory = 2048
	domain.cpus = 2
	override.vm.synced_folder './', '/vagrant', type: 'nfs'
	override.vm.network :forwarded_port, guest: 6379, host: 6379, adapter: device
    end


    ubuntu.vm.provision :shell, :inline => update_ubuntu
    ubuntu.vm.provision :puppet do |puppet|
	puppet.manifests_path = 'manifests'
	puppet.manifest_file  = 'default.pp'
	puppet.options = '--modulepath=/vagrant/modules:/vagrant/static-modules --hiera_config /vagrant/hiera_vagrant.yaml'
    end
  end

end
