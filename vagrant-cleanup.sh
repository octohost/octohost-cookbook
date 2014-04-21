#!/bin/bash
#
# Disable UFW
ufw disable
# Fix the PRIVATE_IP link:
sed -i '5s/.*/PRIVATE_IP=\"192\.168\.62\.86\"/' /etc/default/octohost
# Cleanup to shrink vagrant images.
apt-get -y autoremove
apt-get -y clean
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
rm -rf /tmp/*
sync
