# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: nginx
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

include_recipe 'python'

package 'libgd2-noxpm-dev'

package 'libssl0.9.8'

package 'nginx' do
  action :install
end

service 'nginx' do
  supports status: true
  action [:disable, :stop]
end

%w(/etc/nginx/ssl.key /etc/nginx/ssl.crt).each do |conf|
  cookbook_file conf do
    action :create
  end
end

directory '/etc/nginx/additional-vhosts' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

directory '/var/www/default' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

cookbook_file '/var/www/default/index.html' do
  owner 'root'
  group 'root'
  mode 00644
end

cookbook_file '/etc/nginx/additional-vhosts/00default.conf' do
  owner 'root'
  group 'root'
  mode 00644
  notifies :restart, 'service[proxy]', :delayed
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

%w(
  /etc/octohost/templates/nginx.ctmpl
  /etc/octohost/templates/nginx-ssl.ctmpl
  /etc/octohost/templates/consul-template.cfg
  /etc/octohost/templates/consul-service-watch.json
  /etc/octohost/templates/consul-kv-watch.json
).each do |tmpl|
  cookbook_file tmpl do
    owner 'root'
    group 'root'
    mode 00755
    action :create
  end
end

cookbook_file '/etc/nginx/proxy.conf' do
  source 'proxy.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[proxy]', :delayed
end

cookbook_file '/etc/nginx/ssl.conf' do
  source 'ssl.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[proxy]', :delayed
end

cookbook_file '/etc/nginx/location.conf' do
  source 'location.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[proxy]', :delayed
end

cookbook_file '/etc/init.d/proxy' do
  source 'proxy'
  owner 'root'
  group 'root'
  mode '0755'
  notifies :restart, 'service[proxy]', :delayed
end

cookbook_file '/etc/default/proxy' do
  source 'default-proxy'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[proxy]', :delayed
end

cookbook_file '/etc/nginx/upstream.conf' do
  source 'upstream.conf'
  owner 'root'
  group 'root'
  mode '0644'
  notifies :restart, 'service[proxy]', :delayed
end

cookbook_file '/etc/logrotate.d/nginx' do
  source 'logrotate'
  owner 'root'
  group 'root'
  mode '0644'
end

# Setup GeoIP
directory '/usr/local/share/GeoIP/' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

remote_file '/usr/local/share/GeoIP/GeoIP.dat.gz' do
  source 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCountry/GeoIP.dat.gz'
  owner 'root'
  group 'root'
  not_if { File.exist?('/usr/local/share/GeoIP/GeoIP.dat') }
end

remote_file '/usr/local/share/GeoIP/GeoLiteCity.dat.gz' do
  source 'http://geolite.maxmind.com/download/geoip/database/GeoLiteCity.dat.gz'
  owner 'root'
  group 'root'
  not_if { File.exist?('/usr/local/share/GeoIP/GeoLiteCity.dat') }
end

bash 'unzip the GeoIP files' do
  user 'root'
  cwd '/usr/local/share/GeoIP/'
  code <<-EOH
    gunzip *
  EOH
  not_if { File.exist?('/usr/local/share/GeoIP/GeoLiteCity.dat') }
end

service 'proxy' do
  supports status: true
  action [:enable, :start]
end

python_pip 'ngxtop' do
  action :install
end
