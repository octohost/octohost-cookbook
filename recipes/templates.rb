# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: templates
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

directory '/etc/octohost/templates' do
  owner 'root'
  group 'root'
  mode 00755
  recursive true
  action :create
end

%w(
  /etc/octohost/templates/upstart.conf
).each do |tmpl|
  cookbook_file tmpl do
    owner 'root'
    group 'root'
    mode 00644
    action :create
  end
end
