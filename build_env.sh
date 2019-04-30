#!/bin/bash -ex

apt-get update
apt-get install -y python3-pip git fontconfig make
pip3 install sphinx==2.0.1
mkdir -p /usr/share/fonts/truetype
mkdir -p /usr/share/fonts/opentype
cp -rfv builddocs/files/fonts/truetype/* /usr/share/fonts/truetype/
cp -rfv builddocs/files/fonts/opentype/* /usr/share/fonts/opentype/
fc-cache -f -v
git clone --depth 1 -b ${DOC_BRANCH} https://github.com/saltstack/salt /root/salt
