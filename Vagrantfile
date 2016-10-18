# -*- mode: ruby -*-
# vi: set ft=ruby :

VAGRANTFILE_API_VERSION = '2'
Vagrant.require_version '>= 1.5.0'

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  if Vagrant.has_plugin?('vagrant-proxyconf')
    config.proxy.http     = 'http://webproxy.wlb2.nam.nsroot.net:8080/'
    config.proxy.https    = 'http://webproxy.wlb2.nam.nsroot.net:8080/'
   # config.proxy.no_proxy = "localhost,127.0.0.1,.example.com"
  end

  config.vm.hostname = 'orchestrator'
  config.omnibus.chef_version = :latest
  config.vm.box = 'bento/centos-7.1'
  config.vm.provider 'virtualbox' do |v|
    v.cpus = 1
    v.memory = 2048
  end
  config.vm.synced_folder '~/.aws/', '/home/vagrant/.aws/'
  config.vm.synced_folder 'files/default/orchestrator/', '/home/vagrant/orchestrator/'
  config.vm.provision :chef_solo do |chef|
    chef.run_list = [
        'recipe[cti_orchestrator]'
    ]
  end
end
