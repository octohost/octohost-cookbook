# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::version' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'creates the archive directory' do
    expect(chef_run).to create_directory('/var/archive')
  end

  it 'syncs the octohost/octohost repo' do
    expect(chef_run).to sync_git('/var/archive/octohost').with(repository: 'https://github.com/octohost/octohost.git')
  end

  it 'syncs the octohost/octohost-cookbook repo' do
    expect(chef_run).to sync_git('/var/archive/octohost-cookbook').with(repository: 'https://github.com/octohost/octohost-cookbook.git')
  end

  before  do
    #
  end
end
