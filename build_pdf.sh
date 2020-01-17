#!/bin/bash -ex

. ./build_env.sh

# This is intended to be run in a docker container (possibly using drone)
# and will change your timezone if you run it on your system.
ln -nsf /usr/share/zoneinfo/Etc/UTC /etc/localtime

apt-get install -y texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-xetex latexmk poppler-utils
make -C /root/salt/doc pdf

echo "### Head 200 lines of log ###"
head -n 200 /root/salt/doc/_build/latex/Salt.log
echo "### Tail 200 lines of log ###"
tail -n 200 /root/salt/doc/_build/latex/Salt.log

echo "### Testing PDF ###"
pdfinfo /root/salt/doc/_build/latex/Salt.pdf
