# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: redis
#
# Copyright (C) 2014, Darron Froese <darron@froese.org>
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

service 'redis-server' do
  supports :restart => true # rubocop:disable HashSyntax
  action :nothing
end

cookbook_file '/etc/redis/redis.conf' do
  source 'redis.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[redis-server]', :immediately
end
