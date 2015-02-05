storm-devenv
============

storm-devenv make it easy to construct storm cluster for development and QA.

# Prerequisites

* [Vagrant](https://www.vagrantup.com/)
* [Oracle VirtualBox](https://www.virtualbox.org/)
* [vagrant-aws](https://github.com/mitchellh/vagrant-aws)

Please install these software in advance.

# Setup

```
$ git clone git@github.com:Lewuathe/storm-devenv.git
```

Put your storm code on `site-cookbooks/storm/files/default` as tar format.
If you want to try official release package, you can find it [here](https://storm.apache.org/downloads.html)

```
$ wget http://www.apache.org/dyn/closer.cgi/storm/apache-storm-0.9.3/apache-storm-0.9.3.tar.gz
$ mv apache-storm-0.9.3.tar.gz site-cookbooks/files/default
```

# Launch cluster

```
$ cd storm-devenv
```

## With VirtualBox provider

```
$ export VAGRANT_CWD=./provider/virtualbox && vagrant up
```

## With AWS provider
You have to setup below configurations in environment variables first.

|key|value example|info|
|:---|:---|:---|
|AMI_ID|ami-1234abcd|Available AMI's ID|
|AWS_REGION|us-east-1|Region of EC2 instances|
|AWS_INSTANCE_TYPE|t2.micro|EC2 Instance type|
|AWS_VPC_SUBNET_ID|subnet-1234abcd|Avalable subnet ID|
|AWS_KEYPAIR_NAME|mykey-pair|Key pair name which you have|
|AWS_SECURITY_GROUPS|sg-1234abcd|Available security group|
|AWS_ACCESS_KEY_ID|abcdefg1234567|You AWS access key ID|
|AWS_SECRET_ACCESS_KEY|ABCDEFG1234567|Your AWS secret access key|
|AWS_PRIVATE_KEYPATH|/Users/youanem/.ssh/key.pem|The full path of your AWS key pair|

                                                  
```
$ export VAGRANT_CWD=./provider/aws && vagrant up
```

# Submit Topology

Write your own storm.yaml file `~/.storm/storm.yaml`

```~/.storm/storm.yaml
nimbus.host: "172.30.0.11"
```

If you have launched on EC2, you have to setup this as EC2 nimbus public IP which can be found your AWS dashboard.

And submit your topology. You can read more detail [here](https://storm.apache.org/documentation/Running-topologies-on-a-production-cluster.html)
```
$ storm jar path/to/allmycode.jar org.me.MyTopology arg1 arg2 arg3
```

# Check UI

You can see your cluster UI on [http://172.30.0.11:8080](http://172.30.0.11:8080/index.html)


# License

MIT License. Please see the LICENSE file in details.

# Future works

* Make it easy to change storm version
* Separate storm cookbook as a distinct chef cookbook.
