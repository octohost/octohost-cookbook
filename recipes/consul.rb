# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: consul
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

package 'consul'

directory '/etc/consul.d' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

template '/etc/consul.d/default.json' do
  source 'consul-config.erb'
  owner 'root'
  group 'root'
  mode 00600
  variables consul: node['consul']
end

service 'consul' do
  supports status: true
  action [:enable, :start]
end

package 'consul-webui'

remote_file node['jq']['path'] do
  source node['jq']['url']
  owner 'root'
  group 'root'
  mode '00755'
  action :create
end

cookbook_file '/usr/bin/consulkv' do
  source 'consulkv'
  owner 'root'
  group 'root'
  mode '0755'
end
