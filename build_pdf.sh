#!/bin/bash -ex

./build_env.sh

# This is intended to be run in a docker container (possibly using drone)
# and will change your timezone if you run it on your system.
ln -nsf /usr/share/zoneinfo/Etc/UTC /etc/localtime

apt-get install -y texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-xetex latexmk
make -C /root/salt/doc pdf
