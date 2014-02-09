# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::default' do
  let(:chef_run) { ChefSpec::Runner.new.converge(described_recipe) }

  it 'includes the `ubuntu_base` recipe' do
    expect(chef_run).to include_recipe('ubuntu_base::default')
  end

  it 'includes the `octobase` recipe' do
    expect(chef_run).to include_recipe('octobase::default')
  end

  it 'includes the `docker` recipe' do
    expect(chef_run).to include_recipe('docker::default')
  end

  it 'includes the `redis` recipe' do
    expect(chef_run).to include_recipe('redis::default')
  end

  it 'includes the `serf` recipe' do
    expect(chef_run).to include_recipe('serf::default')
  end

  it 'includes the `gitreceive` recipe' do
    expect(chef_run).to include_recipe('gitreceive::default')
  end
end
