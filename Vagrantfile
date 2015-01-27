# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

ZOOKEEPER_IP = "192.168.50.3"
NIMBUS_IP = "192.168.50.4"
SUPERVISOR_IPs = ["192.168.50.5", "192.168.50.6", "192.168.50.7"]
DRPC_IP = "192.168.50.8"

Vagrant.configure(2) do |config|
  # The most common configuration options are documented and commented below.
  # For a complete reference, please see the online documentation at
  # https://docs.vagrantup.com.

  # Every Vagrant development environment requires a box. You can search for
  # boxes at https://atlas.hashicorp.com/search.
  #config.vm.box = "precise32"

  # The url from where the 'config.vm.box' box will be fetched if it
  # doesn't already exist on the user's system.
  config.vm.box_url = "http://files.vagrantup.com/precise32.box"

  config.vm.define "zookeeper" do |zookeeper|
    zookeeper.vm.box = "precise32"
    zookeeper.vm.network "private_network", ip: ZOOKEEPER_IP
    #zookeeper.vm.network "forwarded_port", guest: 2181, host: 12181
    zookeeper.vm.hostname = "zookeeper"
    zookeeper.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["site-cookbooks", "cookbooks"]
      chef.add_recipe "base"
    end
  end

  config.vm.define "nimbus" do |nimbus|
    nimbus.vm.box = "precise32"
    nimbus.vm.network "private_network", ip: NIMBUS_IP
    nimbus.vm.hostname = "nimbus"
    nimbus.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["site-cookbooks", "cookbooks"]
      chef.add_recipe "storm-cluster::nimbus"
      chef.json = {
        "storm" => {
          :nimbus_ip => NIMBUS_IP,
          :zookeeper_ip => ZOOKEEPER_IP,
          :drpc_ip => DRPC_IP
        }
      }
    end
  end

  (1..3).each do |i|
    config.vm.define "supervisor#{i}" do |supervisor|
      supervisor.vm.box = "precise32"
      supervisor.vm.network "private_network", ip: SUPERVISOR_IPs[i-1]
      supervisor.vm.hostname = "supervisor#{i}"
      supervisor.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = ["site-cookbooks", "cookbooks"]
        chef.add_recipe "storm-cluster::supervisor"
        chef.json = {
          "storm" => {
            :nimbus_ip => NIMBUS_IP,
            :zookeeper_ip => ZOOKEEPER_IP,
            :drpc_ip => DRPC_IP
          }
        }
      end
    end
  end

  config.vm.define "drpc" do |drpc|
    drpc.vm.box = "precise32"
    drpc.vm.network "private_network", ip: DRPC_IP
    drpc.vm.hostname = "drpc"
    drpc.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["site-cookbooks", "cookbooks"]
      chef.add_recipe "storm-cluster::drpc"
      chef.json = {
        "storm" => {
          :nimbus_ip => NIMBUS_IP,
          :zookeeper_ip => ZOOKEEPER_IP,
          :drpc_ip => DRPC_IP
        }
      }
    end
  end
  

  # Create a forwarded port mapping which allows access to a specific port
  # within the machine from a port on the host machine. In the example below,
  # accessing "localhost:8080" will access port 80 on the guest machine.
  # config.vm.network "forwarded_port", guest: 80, host: 8080

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  # config.vm.network "private_network", ip: "192.168.33.10"

  # Create a public network, which generally matched to bridged network.
  # Bridged networks make the machine appear as another physical device on
  # your network.
  # config.vm.network "public_network"

  # Share an additional folder to the guest VM. The first argument is
  # the path on the host to the actual folder. The second argument is
  # the path on the guest to mount the folder. And the optional third
  # argument is a set of non-required options.
  # config.vm.synced_folder "../data", "/vagrant_data"

  # Provider-specific configuration so you can fine-tune various
  # backing providers for Vagrant. These expose provider-specific options.
  # Example for VirtualBox:
  #
  # config.vm.provider "virtualbox" do |vb|
  #   # Display the VirtualBox GUI when booting the machine
  #   vb.gui = true
  #
  #   # Customize the amount of memory on the VM:
  #   vb.memory = "1024"
  # end
  #
  # View the documentation for the provider you are using for more
  # information on available options.

  # Define a Vagrant Push strategy for pushing to Atlas. Other push strategies
  # such as FTP and Heroku are also available. See the documentation at
  # https://docs.vagrantup.com/v2/push/atlas.html for more information.
  # config.push.define "atlas" do |push|
  #   push.app = "YOUR_ATLAS_USERNAME/YOUR_APPLICATION_NAME"
  # end

  # Enable provisioning with a shell script. Additional provisioners such as
  # Puppet, Chef, Ansible, Salt, and Docker are also available. Please see the
  # documentation for more information about their specific syntax and use.
  # config.vm.provision "shell", inline: <<-SHELL
  #   sudo apt-get update
  #   sudo apt-get install -y apache2
  # SHELL
end
