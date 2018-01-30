#!/usr/bin/env bash
set -e

# Time before the kernel kills a connection in CLOSE_WAIT
# reduced to 5 minutes as Vault keeps a lot of connections
echo 'net.ipv4.tcp_keepalive_time = 300' >> /etc/sysctl.conf
sysctl -p

curl -L "${download_url_vault}" > /tmp/vault.zip
curl -L "${download_url_teleport}" > /tmp/teleport.tar.gz

cd /tmp
sudo unzip vault.zip
sudo tar -xzf teleport.tar.gz

sudo mv vault /usr/local/bin
sudo chmod 0755 /usr/local/bin/vault
sudo chown root:root /usr/local/bin/vault

sudo /tmp/teleport/install

sudo systemctl daemon-reload
