storm-devenv
============

storm-devenv make it easy to construct storm cluster for development and QA.

# Prerequisites

* [Vagrant](https://www.vagrantup.com/)
* [Oracle VirtualBox](https://www.virtualbox.org/)

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
$ vagrant up
```

# Submit Topology

Write your own storm.yaml file `~/.storm/storm.yaml`

```~/.storm/storm.yaml
nimbus.host: "192.168.50.4"
```

And submit your topology. You can read more detail [here](https://storm.apache.org/documentation/Running-topologies-on-a-production-cluster.html)
```
$ storm jar path/to/allmycode.jar org.me.MyTopology arg1 arg2 arg3
```

# Check UI

You can see your cluster UI on [http://192.168.50.4:8080](http://192.168.50.4:8080/index.html)

# License

MIT License. Please see the LICENSE file in details.

# Future works

* Make it easy to change storm version
* Separate storm cookbook as a distinct chef cookbook.
