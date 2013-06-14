# -*- mode: ruby -*-
# vi: set ft=ruby :
HERE = File.join(File.dirname(__FILE__))

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  #config.vm.provision :shell, :inline => "echo Hello"

  config.vm.define "web" do |cfg|
    config.vm.box = "web"
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    config.vm.network :forwarded_port, guest: 3000, host: 5000

    cfg.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = File.join(HERE, 'cookbooks')
      chef.add_recipe("apt")
    end
  end
end
