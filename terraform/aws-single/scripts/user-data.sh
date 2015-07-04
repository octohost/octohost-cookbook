#!/bin/bash

# Install keys - they should look like this:
# https://raw.github.com/nonfiction/keys/master/keys
# https://raw.github.com/nonfiction/keys/master/gitreceive-keys
sudo curl -s -L https://link.to.keys.here >> /home/ubuntu/.ssh/authorized_keys
sudo curl -s -L https://link.to.gitreceive.keys.here > /tmp/git_authorized_keys
sudo chown git.git /tmp/git_authorized_keys
sudo chmod 600 /tmp/git_authorized_keys
sudo mv -f /tmp/git_authorized_keys /home/git/.ssh/authorized_keys

# Setup domain name.
sudo sed -i '11s/.*/DOMAIN_SUFFIX=\"example\.com\"/' /etc/default/octohost
sudo sed -i '31s/.*/EMAIL_NOTIFICATION=\"admins@example\.com\"/' /etc/default/octohost
sudo sed -i '36s/.*/LOGSPOUT_TARGET=\"syslog:\/\/logs\.example\.com:xxxxx\"/' /etc/default/octohost
sudo sed -i '40s/.*/REMOTE_SYSLOG_PORT=\"xxxxx\"/' /etc/default/octohost
sudo sed -i '41s/.*/REMOTE_SYSLOG_DESTINATION=\"logs\.example\.com\"/' /etc/default/octohost
