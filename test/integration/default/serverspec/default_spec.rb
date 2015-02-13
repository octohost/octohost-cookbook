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

  describe command('docker info | grep "Storage Driver: aufs"') do
    it { should return_exit_status 0 }
  end

  describe service('proxy') do
    it { should be_enabled }
  end

  describe port(80) do
    it { should be_listening }
  end

  describe port(443) do
    it { should be_listening }
  end

  describe file('/usr/local/bin/ngxtop') do
    it { should be_file }
  end

  describe file('/usr/local/share/GeoIP/GeoLiteCity.dat') do
    it { should be_file }
  end

  describe file('/usr/local/share/GeoIP/GeoIP.dat') do
    it { should be_file }
  end

  describe service('consul') do
    it { should be_enabled }
    it { should be_running }
  end

  describe package('sysdig') do
    it { should be_installed }
  end

  describe file('/usr/local/bin/nsenter') do
    it { should be_file }
  end

  describe file('/usr/local/bin/docker-enter') do
    it { should be_file }
  end

  describe file('/var/archive/octohost') do
    it { should be_directory }
  end

  describe file('/var/archive/octohost-cookbook') do
    it { should be_directory }
  end

  describe file('/var/archive/archive.tgz') do
    it { should be_file }
  end

  describe file('/var/archive/version') do
    it { should be_file }
  end
end
