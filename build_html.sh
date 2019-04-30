#!/bin/bash -ex

./build_env.sh
SALT_ON_SALTSTACK=true make -C /root/salt/doc html
rm -rf /root/salt/doc/_build/html/_sources
echo "ErrorDocument 404 /en/${WEBSITE_RELEASE}/404.html" > /root/salt/doc/_build/html/.htaccess
