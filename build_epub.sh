#!/bin/bash -ex

./build_env.sh
make -C /root/salt/doc epub
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mkdir -f -p /home/ec2-user/en/epub;put -c -O /home/ec2-user/en/epub /root/salt/doc/_build/epub/Salt.epub -o Salt-${WEBSITE_POINT_RELEASE}.epub"
