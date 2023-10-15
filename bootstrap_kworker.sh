#!/bin/bash

# Join worker nodes to the Kubernetes cluster
echo "[TASK 1] Join node to Kubernetes Cluster"
# apt-get  install -y sshpass >/dev/null 2>&1
sudo touch /proc/sys/net/bridge/bridge-nf-call-iptables
#sshpass -p "kubeadmin" scp -o UserKnownHostsFile=/dev/null -o StrictHostKeyChecking=no kmaster.lab.com:/joincluster.sh /joincluster.sh 2>/dev/null
# sshpass -p "kubeadmin" scp -o StrictHostKeyChecking=no root@kmaster.lab.com:/joincluster.sh ./joincluster.sh
config_path="/vagrant/configs"

sudo bash $config_path/joincluster.sh 
