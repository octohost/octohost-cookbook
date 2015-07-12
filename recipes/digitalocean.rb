# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: digitalocean
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

bash 'Update PUBLIC_IP as the eth0 interface.' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sed -i '8s/.*/PUBLIC_IP=\$(ifconfig eth0 \| grep \"inet addr\" \| cut --delimiter=\":\" -f 2 \| cut --delimiter=\" \" -f 1)/' /etc/default/octohost
  EOH
end

bash 'Update PRIVATE_IP as the eth1 interface.' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sed -i '9s/.*/PRIVATE_IP=\$(ifconfig eth1 \| grep \"inet addr\" \| cut --delimiter=\":\" -f 2 \| cut --delimiter=\" \" -f 1)/' /etc/default/octohost
  EOH
end
