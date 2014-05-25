# -*- mode: ruby -*-
# vi: set ft=ruby :

# Vagrantfile API/syntax version. Don't touch unless you know what you're doing!
VAGRANTFILE_API_VERSION = "2"

Vagrant.configure(VAGRANTFILE_API_VERSION) do |config|

  # Every Vagrant virtual environment requires a box to build off of.
  config.vm.box = "opscode-ubuntu-14.04"

  # Create a private network, which allows host-only access to the machine
  # using a specific IP.
  #
  # IMPORTANT NOTE:
  #
  # *.octodev.io points to 192.168.62.86 - you can use it for your own
  #   local octohost
  #
  config.vm.network :private_network, ip: "192.168.62.86"

  # Install: vagrant plugin install vagrant-omnibus
  config.omnibus.chef_version = :latest

  config.vm.provision :chef_solo do |chef|
    chef.cookbooks_path = "./vendor/cookbooks"
    chef.add_recipe "octohost"
    # Make sure to update the ssh key attributes in attributes/default.rb
    chef.add_recipe "octohost::vagrant"
  end
end
