#! /bin/bash

# 在管理员节点安装ansible
if [ -x "$(command -v yum)" ];then
  yum install epel-release
  yum install -y ansible
elif [ -x "$(command -v apt-get)" ];then
  apt-add-repository ppa:ansible/ansible
  apt-get update
  apt-get install ansible
else
  echo "$(date -d tody + '%Y-%m-%d %H:%M:%S') -[ERROR] -unknown command."
  exit
fi

# 配置远程主机节点的SSH
# 这里假设远程节点有 kube-node1、kube-node2、kube-node3
ssh-keygen
ssh-copy-id root@kube-node1 
ssh-copy-id root@kube-node2
ssh-copy-id root@kube-node3

ssh-keyscan kube-node1 kube-node2 kube-node3 >> ~/.ssh/known_hosts
