# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::consul_template' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'installs the consul-template package' do
    expect(chef_run).to install_package('consul-template')
  end

  before  do
    #
  end
end
