# encoding: utf-8
#
# Cookbook Name:: octohost
# Attributes:: default
#
# Copyright (C) 2013, Darron Froese <darron@froese.org>
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

default['vagrant']['keys'] = 'https://raw.github.com/nonfiction/keys/master/keys'
default['git']['keys'] = 'https://raw.github.com/nonfiction/keys/master/gitreceive-keys'

default['ruby']['version'] = '2.1'

default['consul']['encrypt'] = 'p4T1eTQtKji/Df3VrMMLzg=='
default['consul']['install_method'] = 'binary'
default['consul']['data_dir'] = '/var/cache/octohost'
default['consul']['bind_addr'] = '192.168.62.86'
default['consul']['client_address'] = '192.168.62.86'
default['consul']['datacenter'] = 'dc1'
default['consul']['enable_syslog'] = true
default['consul']['node_name'] = 'octodev-master'
default['consul']['install_dir'] = '/usr/local/bin'
default['consul']['recursor'] = '8.8.8.8'
default['consul']['service_user'] = 'root'
default['consul']['service_group'] = 'root'

default['consul']['serve_ui'] = true

default['jq']['url'] = 'http://stedolan.github.io/jq/download/linux64/jq'
default['jq']['path'] = '/usr/bin/jq'
