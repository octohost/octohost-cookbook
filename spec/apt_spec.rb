# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::apt' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'adds the packagecloud repo' do
    expect(chef_run).to create_packagecloud_repo('darron/octohost')
  end

  before  do
    #
  end
end
