#!/bin/bash -ex

./build_env.sh
apt-get install -y texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-xetex latexmk
make -C /root/salt/doc pdf
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mkdir -f -p /home/ec2-user/en/pdf;put -c -O /home/ec2-user/en/pdf /root/salt/doc/_build/latex/Salt.pdf -o Salt-${WEBSITE_POINT_RELEASE}.pdf"
