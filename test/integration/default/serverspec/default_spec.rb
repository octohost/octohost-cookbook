# encoding: utf-8
require 'spec_helper'

# Write integration tests with Serverspec - http://serverspec.org/
describe 'octohost::default' do
  describe service('ntp') do
    it { should be_enabled }
    it { should be_running }
  end

  describe service('docker') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(4243) do
    it { should be_listening }
  end

  describe service('redis-server') do
    it { should be_enabled }
    it { should be_running }
  end

  describe port(6379) do
    it { should be_listening }
  end

  describe service('proxy') do
    it { should be_enabled }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe port(81) do
    it { should be_listening }
  end

  describe file('/usr/local/bin/ngxtop') do
    it { should be_file }
  end

  describe service('etcd') do
    it { should be_enabled }
    it { should be_running }
  end

  describe package('sysdig') do
    it { should be_installed }
  end
end
