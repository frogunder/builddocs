#!/bin/bash -ex

ln -nsf /usr/share/zoneinfo/Etc/UTC /etc/localtime
apt-get update
apt-get install -y python3-sphinx lftp git openssh-client fontconfig texlive-latex-recommended texlive-latex-extra texlive-fonts-recommended texlive-xetex make
git clone --depth 1 -b ${DOC_BRANCH} https://github.com/saltstack/salt /root/salt
mkdir -p /usr/share/fonts/truetype
mkdir -p /usr/share/fonts/opentype
cp -rfv builddocs/files/fonts/truetype/* /usr/share/fonts/truetype/
cp -rfv builddocs/files/fonts/opentype/* /usr/share/fonts/opentype/
fc-cache -f -v
SALT_ON_SALTSTACK=true make -C /root/salt/doc html
rm -rf /root/salt/doc/_build/html/_sources
echo "ErrorDocument 404 /en/${WEBSITE_RELEASE}/404.html" > /root/salt/doc/_build/html/.htaccess
make -C /root/salt/doc pdf
make -C /root/salt/doc epub
find /root/salt/doc
mkdir /root/.ssh
echo "StrictHostKeyChecking no" > /root/.ssh/config
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mirror -v -c --delete --reverse --use-cache /root/salt/doc/_build/html/ref /home/ec2-user/en/${WEBSITE_RELEASE}/ref"
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mirror -v -c --delete --reverse --use-cache /root/salt/doc/_build/html/topics /home/ec2-user/en/${WEBSITE_RELEASE}/topics"
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mirror -v -c --reverse --use-cache /root/salt/doc/_build/html /home/ec2-user/en/${WEBSITE_RELEASE}"
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mkdir -f -p /home/ec2-user/en/pdf;put -c -O /home/ec2-user/en/pdf /root/salt/doc/_build/latex/Salt.pdf -o Salt-${WEBSITE_POINT_RELEASE}.pdf"
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mkdir -f -p /home/ec2-user/en/epub;put -c -O /home/ec2-user/en/epub /root/salt/doc/_build/epub/Salt.epub -o Salt-${WEBSITE_POINT_RELEASE}.epub"
