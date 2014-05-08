#!/bin/bash
#
# Disable UFW
ufw disable
# Cleanup to shrink vagrant images.
apt-get -y autoremove
apt-get -y clean
dd if=/dev/zero of=/EMPTY bs=1M
rm -f /EMPTY
rm -rf /tmp/*
sync
