#!/bin/bash

HOSTNAME=`hostname`
ETC_HOSTS=${1:-/etc/hosts}
ZOOKEEPER_IP="172.30.0.10"
NIMBUS_IP="172.30.0.11"
SUPERVISOR_NAMEs=("supervisor1" "supervisor2" "supervisor3")
SUPERVISOR_IPs=("172.30.0.12" "172.30.0.13" "172.30.0.14")
DRPC_IP="172.30.0.15"

echo "$ZOOKEEPER_IP   zookeeper" >> /etc/hosts
echo "$NIMBUS_IP      nimbus" >> /etc/hosts
echo "$DRPC_IP        drpc" >> /etc/hosts

for i in `seq 0 3`
do
  echo "${SUPERVISOR_IPs[$i]}  ${SUPERVISOR_NAMEs[$i]}" >> /etc/hosts
done

