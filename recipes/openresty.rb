# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: openresty
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

service 'nginx' do
  supports :status => true # rubocop:disable HashSyntax
  action [:disable, :stop]
end

%w(/etc/nginx/ssl.key /etc/nginx/ssl.crt).each do |conf|
  cookbook_file conf do
    action :create
  end
end

cookbook_file '/etc/nginx/proxy.conf' do
  source 'proxy.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/etc/nginx/api.conf' do
  source 'api.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/etc/init.d/proxy' do
  source 'proxy'
  owner 'root'
  group 'root'
  mode '0755'
end

cookbook_file '/etc/default/proxy' do
  source 'default-proxy'
  owner 'root'
  group 'root'
  mode '0644'
end

cookbook_file '/etc/nginx/upstream.conf' do
  source 'upstream.conf'
  owner 'root'
  group 'root'
  mode '0644'
end

service 'proxy' do
  supports :status => true # rubocop:disable HashSyntax
  action [:enable, :start]
end

# Add ngxtop
package 'python-pip'

bash 'install ngxtop' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    pip install ngxtop
  EOH
end
