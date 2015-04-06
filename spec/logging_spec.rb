# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::logging' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates the logging directory' do
    expect(chef_run).to create_directory('/var/log/octohost')
  end

  it 'touches the first logfile' do
    expect(chef_run).to create_file('/var/log/octohost/octohost')
  end

  it 'creates the rsyslog file for octohost' do
    expect(chef_run).to create_cookbook_file('/etc/rsyslog.d/30-octohost.conf')
  end

  before  do
    #
  end
end
