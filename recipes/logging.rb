# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: logging
#
# Copyright (C) 2015, Darron Froese <darron@froese.org>
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

include_recipe 'rsyslog'

directory '/var/log/octohost' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

file '/var/log/octohost/octohost' do
  owner 'syslog'
  group 'adm'
  mode 00644
  action :create
end

cookbook_file '/etc/rsyslog.d/30-octohost.conf' do
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[rsyslog]'
end

logrotate_app 'octohost' do
  cookbook 'logrotate'
  path '/var/log/octohost/octohost'
  frequency 'weekly'
  rotate 7
  create '644 syslog adm'
  options ['missingok', 'compress', 'notifempty', 'copytruncate']
  enable true
end
