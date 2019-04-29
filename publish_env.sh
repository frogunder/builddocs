#!/bin/bash -ex

apt-get update
apt-get install -y lftp openssh-client
mkdir /root/.ssh
echo "StrictHostKeyChecking no" > /root/.ssh/config
