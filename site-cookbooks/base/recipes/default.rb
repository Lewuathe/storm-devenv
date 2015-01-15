#
# Cookbook Name:: base
# Recipe:: default
#
# Copyright 2015, YOUR_COMPANY_NAME
#
# All rights reserved - Do Not Redistribute
#

include_recipe "zookeeper"

zookeeper '3.4.6' do
  user     'zookeeper'
  mirror   'http://www.poolsaboveground.com/apache/zookeeper'
  checksum '01b3938547cd620dc4c93efe07c0360411f4a66962a70500b163b59014046994'
  action   :install
end

service 'zookeeper' do
  start_command 'sudo /opt/zookeeper/zookeeper-3.4.6/bin/zkServer.sh start'
  action :start
end

#config_hash = {
#  clientPort: 2181, 
#  dataDir: '/mnt/zk', 
#  tickTime: 2000,
#  autopurge: {
#    snapRetainCount: 1,
#    purgeInterval: 1
#  }
#}
#
#zookeeper_config '/opt/zookeeper/zookeeper-3.4.6/conf/zoo.cfg' do
#  config config_hash
#  user   'zookeeper'
#  action :render
#end
