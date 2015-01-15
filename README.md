storm-devenv
============

storm-devenv make it easy to construct storm cluster for development and QA.

# Setup

```
$ git clone git@github.com:Lewuathe/storm-devenv.git
```

Put your storm code on `site-cookbooks/storm/files/default` as tar format.
If you want to try official release package, you can find it [here](https://storm.apache.org/downloads.html)

# Launch cluster

```
$ cd storm-devenv
$ vagrant up
```

# Submit Topology

Write your own storm.yaml file under `~/.storm`

```~/.storm/storm.yaml
nimbus.host: "192.168.50.4"
```

# Check UI

You can see your cluster UI on [http://192.168.50.4:8080](http://192.168.50.4:8080/index.html)

# License

MIT License. Please see the LICENSE file in details.
