# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::final' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'adds git to the docker group' do
    expect(chef_run).to modify_group('docker').with(members: ['git'])
  end

  before  do
    #
  end
end
