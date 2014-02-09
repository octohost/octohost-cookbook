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

  # describe service('hipache') do
  #   it { should be_enabled }
  #   it { should be_running }
  # end
  # 
  # describe port(80) do
  #   it { should be_listening }
  # end

  describe service('serf') do
    it { should be_enabled }
    it { should be_running }
  end
end
