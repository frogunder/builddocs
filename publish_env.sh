#!/bin/bash -ex

apt-get update
apt-get install -y lftp openssh-client
mkdir /root/.ssh
echo "[saltstackdocs.wpengine.com]:2222 ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABAQCjspaC9pvm+oZmSRDSCbeLIx0IkUL+0yFp1lk2SqcgAvFB1nxS6zcinf6czEyjKPdvCiK2Eb2rcp2lLCfqBpEeEMakKd9TFrBhjKsy7GUNPhvnX6vuCyfviQ9VF9A3EEVS8+hDQUK4QlQqYgfwX8el+qm7drZ4w70dNR6ADFwfNmFFPQB9mS9sFhxCy0Iv176ycohL6BB/6o9VfdtEl/OyCt8ajn7VHwL9/odQskclmFcAT+NGbSoI9jWPyNJqaPbTZHZ81KnjH4U0O1HVXDHj0o03kQr4FTj0R0po5ah4eZdHnTe3BPdaR6NfggxXwofnCxDHXWGEAzw29RxCJCzf" >> /root/.ssh/known_hosts
#echo "StrictHostKeyChecking no" > /root/.ssh/config
