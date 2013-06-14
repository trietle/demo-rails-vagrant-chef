# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|
  config.vm.box = "precise64"
  config.vm.box_url = "http://files.vagrantup.com/precise64.box"
  #config.vm.provision :shell, :inline => "echo Hello"

  config.vm.define "web" do |cfg|
    config.vm.box = "web"
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: "192.168.33.20"
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    #config.vm.network :forwarded_port, guest: 3000, host: 5000

    cfg.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe("apt")
      chef.add_recipe("main")
      chef.add_recipe("postgresql::client")
      chef.json = {
        :user => {
          :name => "deployer",
          :password => "$1$vcvMS62r$.nB8ioOmjczCT60ZkH9zi0" #=> use `openssl passwd -1 "deployer"` to generate hash pw
        }
      }
    end
  end

  config.vm.define "database" do |cfg|
    config.vm.box = "database"
    # Create a private network, which allows host-only access to the machine
    # using a specific IP.
    config.vm.network :private_network, ip: "192.168.33.25"
    # Create a forwarded port mapping which allows access to a specific port
    # within the machine from a port on the host machine. In the example below,
    # accessing "localhost:8080" will access port 80 on the guest machine.
    #config.vm.network :forwarded_port, guest: 5432, host: 5433
    #config.vm.network :forwarded_port, guest: 80, host: 8080

    cfg.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = 'cookbooks'
      chef.add_recipe("apt")
      chef.add_recipe("postgresql::server")
      chef.json = {
        :postgresql => {
          :version  => "9.1",
          :listen_addresses => "*",
          :pg_hba => [
            "host all all 0.0.0.0/0 md5",
            "host all all ::1/0 md5",
          ],
          :users => [
            { :username => "postgres", :password => "postgres",
              :superuser => true, :login => true, :createdb => true },
            { :username => "deployer", :password => "deployer",
              :superuser => false, :login => true, :createdb => false }
          ],
          :databases => [ { :name => "db-production", :owner => "deployer", :encoding => "utf8" }
          ]
        }
      }
    end
  end
end
