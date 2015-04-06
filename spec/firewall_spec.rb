# encoding: utf-8
require 'spec_helper'

# Write unit tests with ChefSpec - https://github.com/sethvargo/chefspec#readme
describe 'octohost::firewall' do
  cached(:chef_run) { ChefSpec::SoloRunner.new.converge(described_recipe) }

  it 'includes the `firewall` recipe' do
    expect(chef_run).to include_recipe('firewall::default')
  end

  it 'installs the ufw package' do
    expect(chef_run).to install_package('ufw')
  end

  it 'enables the firewall' do
    expect(chef_run).to enable_firewall('ufw')
  end

  it 'allows ssh' do
    expect(chef_run).to allow_firewall_rule('ssh').with_port(22)
  end

  it 'allows http' do
    expect(chef_run).to allow_firewall_rule('http').with_port(80)
  end

  it 'allows https' do
    expect(chef_run).to allow_firewall_rule('https').with_port(443)
  end

  it 'allows docker' do
    expect(chef_run).to allow_firewall_rule('docker0').with_interface('docker0')
  end

  before  do
    #
  end
end
