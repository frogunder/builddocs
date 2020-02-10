#!/bin/bash -ex

export LATEST_RELEASE='3000'
export PREVIOUS_RELEASE='2019.2.3'
export PREVIOUS_RELEASE_DIR='2019.2'

apt-get update
apt-get install -y python3-pip git fontconfig make
pip3 install sphinx==2.0.1
mkdir -p /usr/share/fonts/truetype
mkdir -p /usr/share/fonts/opentype
cp -rfv builddocs/files/fonts/truetype/* /usr/share/fonts/truetype/
cp -rfv builddocs/files/fonts/opentype/* /usr/share/fonts/opentype/
fc-cache -f -v
git clone --depth 1 -b ${DOC_BRANCH} https://github.com/saltstack/salt /root/salt
