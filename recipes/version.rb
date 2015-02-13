# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: version
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

directory '/var/archive' do
  owner 'root'
  group 'root'
  mode '0755'
  recursive true
  action :create
end

git '/var/archive/octohost' do
  repository 'https://github.com/octohost/octohost.git'
  action :sync
end

git '/var/archive/octohost-cookbook' do
  repository 'https://github.com/octohost/octohost-cookbook.git'
  action :sync
end

remote_file '/tmp/chefdk.deb' do
  source node['octohost']['chefdk_url']
  owner 'root'
  group 'root'
end

dpkg_package '/tmp/chefdk.deb' do
  action :install
end

bash 'get SHA values' do
  user 'root'
  cwd '/var/archive'
  code <<-EOH
    cd octohost
    OCTOHOST_VERSION=$(git rev-parse HEAD)
    cd ../octohost-cookbook
    COOKBOOK_VERSION=$(git rev-parse HEAD)
    echo "octohost: https://github.com/octohost/octohost/commit/$OCTOHOST_VERSION" > /var/archive/version
    echo "cookbook: https://github.com/octohost/octohost-cookbook/commit/$COOKBOOK_VERSION" >> /var/archive/version
  EOH
end

bash 'vendor all of the cookbooks' do
  user 'root'
  cwd '/var/archive/octohost-cookbook'
  code <<-EOH
    eval "$(chef shell-init bash)"
    berks vendor vendor/cookbooks
  EOH
end

bash 'tar it all up' do
  user 'root'
  cwd '/var'
  code <<-EOH
    tar -czf archive.tgz archive
    mv -f archive.tgz archive/
  EOH
end
