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

remote_file "#{Chef::Config[:file_cache_path]}/consul-template.tar.gz" do
  source 'https://github.com/hashicorp/consul-template/releases/download/v0.5.1/consul-template_0.5.1_linux_amd64.tar.gz'
  checksum '059574057cebbc95423b99cad18c5198195506ac1f743c8b0e17f60870ed992a'
end

bash 'expand consul-template' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    tar -xvf #{Chef::Config[:file_cache_path]}/consul-template.tar.gz -C /usr/local/bin/ --strip-components=1
  EOH
  not_if { File.exist?('/usr/local/bin/consul-template') }
end

file '/usr/local/bin/consul-template' do
  owner 'root'
  group 'root'
  mode 00755
  action :create
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
