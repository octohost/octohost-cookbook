# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: private_ip
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

# This works better for Azure and shouldn't affect anything else.
bash 'Update PRIVATE_IP as the eth0 interface.' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sed -i '9s/.*/PRIVATE_IP=\$(ifconfig eth0 \| grep \"inet addr\" \| cut --delimiter=\":\" -f 2 \| cut --delimiter=\" \" -f 1)/' /etc/default/octohost
  EOH
end

execute 'install keys to push to git user' do # ~FC041
  command "curl -L #{node['git']['keys']} >> /home/git/.ssh/authorized_keys"
  not_if { File.exist?('/home/git/.ssh/authorized_keys') }
end
