# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: vagrant
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

package 'curl'

execute 'install keys for vagrant user' do # ~FC041
  command "curl #{node['vagrant']['keys']} >> /home/vagrant/.ssh/authorized_keys"
end

execute 'install keys to push to git user' do # ~FC041
  command "curl #{node['git']['keys']} >> /home/git/.ssh/authorized_keys"
end

bash 'update domain name in /usr/bin/octo and /home/git/receiver' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    sed "s/\\$PUBLIC_IP\.xip\.io/octodev\.io/" /usr/bin/octo --in-place
    sed "s/DOMAIN_SUFFIX=\\"\\$PUBLIC_IP\.xip\.io/DOMAIN_SUFFIX=\\"octodev\.io/" /home/git/receiver --in-place
    sed "s/\\$PUBLIC_IP\.xip\.io/192\.168\.62\.86\.xip\.io/" /home/git/receiver --in-place
    sed "s/\^PUBLIC_IP/# PUBLIC_IP/" /usr/bin/octo --in-place
    sed "s/\^PUBLIC_IP/# PUBLIC_IP/" /home/git/receiver --in-place
  EOH
end
