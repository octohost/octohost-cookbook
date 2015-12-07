# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::vault' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs the vault package' do
    expect(chef_run).to install_package('vault')
  end

  before do
    #
  end
end
