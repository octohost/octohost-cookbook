# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::consul' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs the consul package' do
    expect(chef_run).to install_package('consul')
  end

  it 'enables and starts the consul service' do
    expect(chef_run).to enable_service('consul')
    expect(chef_run).to start_service('consul')
  end

  it 'creates the consul configuration directory' do
    expect(chef_run).to create_directory('/etc/consul.d')
  end

  it 'creates the consul configuration template' do
    expect(chef_run).to create_template('/etc/consul.d/default.json')
  end

  it 'installs the consul-webui package' do
    expect(chef_run).to install_package('consul-webui')
  end

  it 'installs the jq remote file' do
    expect(chef_run).to create_remote_file('/usr/bin/jq')
  end

  it 'installs the consulkv file' do
    expect(chef_run).to create_cookbook_file('/usr/bin/consulkv')
  end

  before  do
    #
  end
end
