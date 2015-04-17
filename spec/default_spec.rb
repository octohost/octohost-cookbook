# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::default' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes the `ubuntu_base` recipe' do
    expect(chef_run).to include_recipe('ubuntu_base::default')
  end

  it 'includes the `octobase` recipe' do
    expect(chef_run).to include_recipe('octobase::default')
  end

  it 'includes the `gitreceive` recipe' do
    expect(chef_run).to include_recipe('gitreceive::default')
  end

  it 'includes the `python` recipe' do
    expect(chef_run).to include_recipe('python::default')
  end

  before  do
    stub_command("grep 'x:999' /etc/passwd").and_return(0)
  end
end
