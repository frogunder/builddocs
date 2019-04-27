#!/bin/bash -ex

ln -nsf /usr/share/zoneinfo/Etc/UTC /etc/localtime
apt-get update
apt-get install -y python3-pip lftp git openssh-client fontconfig make
pip3 install sphinx==2.0.1
git clone --depth 1 -b ${DOC_BRANCH} https://github.com/bryceml/salt /root/salt
mkdir -p /usr/share/fonts/truetype
mkdir -p /usr/share/fonts/opentype
cp -rfv builddocs/files/fonts/truetype/* /usr/share/fonts/truetype/
cp -rfv builddocs/files/fonts/opentype/* /usr/share/fonts/opentype/
fc-cache -f -v
mkdir /root/.ssh
echo "StrictHostKeyChecking no" > /root/.ssh/config
