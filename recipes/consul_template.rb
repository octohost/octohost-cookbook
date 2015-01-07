# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: consul_template
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

ark 'consul-template' do
  url node['octohost']['consul-template']['url']
  has_binaries ['consul-template']
  version node['octohost']['consul-template']['version']
  mode 00755
  action :install
end

directory '/etc/nginx/containers' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

directory '/etc/nginx/templates' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

%w(/etc/nginx/template.ctmpl /etc/nginx/template.cfg /etc/nginx/template.watch /etc/nginx/template.kv.watch).each do |tmpl|
  cookbook_file tmpl do
    owner 'root'
    group 'root'
    mode 00755
    action :create
  end
end
