# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: docker
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

include_recipe 'docker::default'

cookbook_file '/etc/default/docker' do
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[docker]', :delayed
end

cookbook_file '/etc/init/docker.conf' do
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[docker]', :immediately
end

remote_file '/usr/local/bin/docker-machine' do
  source 'https://github.com/docker/machine/releases/download/v0.3.0/docker-machine_linux-amd64'
  owner 'root'
  group 'root'
  mode 00755
end
