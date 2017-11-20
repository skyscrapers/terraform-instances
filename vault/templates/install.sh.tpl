#!/usr/bin/env bash
set -e

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
sudo systemctl enable vault.service
sudo systemctl start vault.service
sudo systemctl enable teleport.service
sudo systemctl start teleport.service
