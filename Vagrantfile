# -*- mode: ruby -*-
# vi: set ft=ruby :

# All Vagrant configuration is done below. The "2" in Vagrant.configure
# configures the configuration version (we support older styles for
# backwards compatibility). Please don't change it unless you know what
# you're doing.

#-- VPC IP Address --#
ZOOKEEPER_IP = "172.30.0.10"
NIMBUS_IP = "172.30.0.11"
SUPERVISOR_IPs = ["172.30.0.12", "172.30.0.13", "172.30.0.14"]
DRPC_IP = "172.30.0.15"

#-- AWS EC2 configuration --#
AMI_ID = ENV['AMI_ID']
AWS_REGION = ENV['AWS_REGION']
AWS_INSTANCE_TYPE = ENV['AWS_INSTANCE_TYPE']
AWS_VPC_SUBNET_ID = ENV['AWS_VPC_SUBNET_ID']
AWS_KEYPAIR_NAME = ENV['AWS_KEYPAIR_NAME']
## This security group have to be accessible from my machine
AWS_SECURITY_GROUPS = [ENV['AWS_SECURITY_GROUP']]

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
    zookeeper.vm.box = "dummy"
    zookeeper.vm.network "private_network", ip: ZOOKEEPER_IP
    zookeeper.vm.provider :aws do |aws, override| 
      #-- User settings --#
      aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
      aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
      aws.ami = AMI_ID
      aws.tags = {
        'Name' => 'ZooKeeper'
      }
      aws.keypair_name = AWS_KEYPAIR_NAME

      #-- Instance settings --#
      aws.private_ip_address = ZOOKEEPER_IP
      aws.region = AWS_REGION
      aws.subnet_id = AWS_VPC_SUBNET_ID
      aws.instance_type = AWS_INSTANCE_TYPE
      #aws.elastic_ip = true
      aws.security_groups = AWS_SECURITY_GROUPS

      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = ENV["AWS_PRIVATE_KEYPATH"]
    end
    zookeeper.vm.hostname = "zookeeper"
    zookeeper.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["./site-cookbooks", "./cookbooks"]
      chef.add_recipe "base"
    end
  end

  config.vm.define "nimbus" do |nimbus|
    nimbus.vm.box = "dummy"
    nimbus.vm.network "private_network", ip: NIMBUS_IP
    nimbus.vm.hostname = "nimbus"
    nimbus.vm.provider :aws do |aws, override|
      #-- User settings --#
      aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
      aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
      aws.ami = AMI_ID
      aws.tags = {
        'Name' => 'Nimbus'
      }
      aws.keypair_name = AWS_KEYPAIR_NAME
      
      #-- Instance settings --#
      aws.private_ip_address = NIMBUS_IP
      aws.region = AWS_REGION
      aws.subnet_id = AWS_VPC_SUBNET_ID
      aws.instance_type = AWS_INSTANCE_TYPE
      #aws.elastic_ip = true
      aws.security_groups = AWS_SECURITY_GROUPS

      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = ENV["AWS_PRIVATE_KEYPATH"]
    end
    nimbus.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["./site-cookbooks", "./cookbooks"]
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
      supervisor.vm.box = "dummy"
      supervisor.vm.network "private_network", ip: SUPERVISOR_IPs[i-1]
      supervisor.vm.hostname = "supervisor#{i}"
      supervisor.vm.provider :aws do |aws, override|
        aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
        aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
        aws.ami = AMI_ID
        aws.tags = {
          'Name' => "Supervisor#{i}"
        }
        aws.keypair_name = AWS_KEYPAIR_NAME

        #-- Instance settings --#
        aws.private_ip_address = SUPERVISOR_IPs[i-1]
        aws.region = AWS_REGION
        aws.subnet_id = AWS_VPC_SUBNET_ID
        #aws.instance_type = AWS_INSTANCE_TYPE
        aws.elastic_ip = true
        aws.security_groups = AWS_SECURITY_GROUPS

        override.ssh.username = "ubuntu"
        override.ssh.private_key_path = ENV["AWS_PRIVATE_KEYPATH"]
      end
      supervisor.vm.provision :chef_solo do |chef|
        chef.cookbooks_path = ["./site-cookbooks", "./cookbooks"]
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
    drpc.vm.box = "dummy"
    drpc.vm.network "private_network", ip: DRPC_IP
    drpc.vm.hostname = "drpc"
    drpc.vm.provider :aws do |aws, override|
      aws.access_key_id = ENV["AWS_ACCESS_KEY_ID"]
      aws.secret_access_key = ENV["AWS_SECRET_ACCESS_KEY"]
      aws.ami = AMI_ID
      aws.tags = {
        'Name' => 'DRPC'
      }
      aws.keypair_name = AWS_KEYPAIR_NAME

      #-- Instance settings --#
      aws.private_ip_address = DRPC_IP
      aws.region = AWS_REGION
      aws.subnet_id = AWS_VPC_SUBNET_ID
      aws.instance_type = AWS_INSTANCE_TYPE
      #aws.elastic_ip = true
      aws.security_groups = AWS_SECURITY_GROUPS
 
      override.ssh.username = "ubuntu"
      override.ssh.private_key_path = ENV["AWS_PRIVATE_KEYPATH"]
    end
    drpc.vm.provision :chef_solo do |chef|
      chef.cookbooks_path = ["./site-cookbooks", "./cookbooks"]
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
end
