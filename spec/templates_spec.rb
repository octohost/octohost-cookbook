# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::templates' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates the templates configuration directory' do
    expect(chef_run).to create_directory('/etc/octohost/templates')
  end

  it 'installs the upstart file' do
    expect(chef_run).to create_cookbook_file('/etc/octohost/templates/upstart.conf')
  end

  before  do
    #
  end
end
