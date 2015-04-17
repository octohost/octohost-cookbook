# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::docker' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes the `docker` recipe' do
    expect(chef_run).to include_recipe('docker::default')
  end

  it 'installs the docker file' do
    expect(chef_run).to create_cookbook_file('/etc/default/docker')
  end

  it 'installs the docker.conf file' do
    expect(chef_run).to create_cookbook_file('/etc/init/docker.conf')
  end

  before  do
    stub_command("grep 'x:999' /etc/passwd").and_return(0)
  end
end
