#!/bin/bash
sudo apt-get install -y ruby1.9.1 ruby1.9.1-dev
sudo gem install bundler serverspec --no-ri --no-rdoc
cd /tmp/test/integration/default/serverspec/
# /usr/bin/ruby -S rspec default_spec.rb
