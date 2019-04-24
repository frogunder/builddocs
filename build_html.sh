#!/bin/bash -ex

./build_env.sh
SALT_ON_SALTSTACK=true make -C /root/salt/doc html
rm -rf /root/salt/doc/_build/html/_sources
echo "ErrorDocument 404 /en/${WEBSITE_RELEASE}/404.html" > /root/salt/doc/_build/html/.htaccess
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mirror -v -c --delete --reverse --use-cache /root/salt/doc/_build/html/ref /home/ec2-user/en/${WEBSITE_RELEASE}/ref"
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mirror -v -c --delete --reverse --use-cache /root/salt/doc/_build/html/topics /home/ec2-user/en/${WEBSITE_RELEASE}/topics"
lftp -c "open -u ec2-user,${WEBSITE_PASSWORD} -p 2222 sftp://10.27.56.107;mirror -v -c --reverse --use-cache /root/salt/doc/_build/html /home/ec2-user/en/${WEBSITE_RELEASE}"
