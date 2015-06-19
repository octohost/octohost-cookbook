#!/bin/bash
#
# Disable UFW
ufw disable
# Cleanup to shrink vagrant images.
#apt-get update
#apt-get upgrade -y
apt-get -y autoremove
apt-get -y clean
rm -f /var/chef/cache/chefdk.deb
rm -rf /var/lib/apt/lists/*
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
rm -rf /tmp/*
sync
