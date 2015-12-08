#!/bin/bash
source /etc/default/octohost
sudo service consul stop || true
sudo rm -rf /var/cache/octohost/*
CONSUL_KEY=$(consul keygen)
HOSTNAME=$(hostname)
sudo cat > /tmp/consul.json <<EOF
{
  "encrypt": "$CONSUL_KEY",
  "data_dir": "/var/cache/octohost",
  "datacenter": "dc1",
  "enable_syslog": true,
  "node_name": "$HOSTNAME",
  "recursor": "8.8.8.8",
  "server": true,
  "bootstrap": true,
  "ui_dir": "/var/lib/consul/ui",
  "client_addr": "127.0.0.1",
  "advertise_addr": "127.0.0.1"
}
EOF
sudo mv -f /tmp/consul.json /etc/consul.d/default.json
sudo chown root.root /etc/consul.d/default.json
sudo service consul start
