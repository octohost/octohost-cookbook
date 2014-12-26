# encoding: utf-8
#
# Cookbook Name:: octohost
# Recipe:: final
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

# Add git, vagrant and ubuntu to docker group.
group 'docker' do
  action :modify
  members 'ubuntu'
  append true
  only_if { File.exist?('/home/ubuntu') }
end

group 'docker' do
  action :modify
  members 'vagrant'
  append true
  only_if { File.exist?('/home/vagrant') }
end

group 'docker' do
  action :modify
  members 'git'
  append true
end

# Thanks http://programster.blogspot.ca/2014/09/docker-implementing-container-memory.html

bash 'remove warning when adding memory limits for docker containers' do
  user 'root'
  cwd '/tmp'
  code <<-EOH
    SEARCH='GRUB_CMDLINE_LINUX=""'
    REPLACE='GRUB_CMDLINE_LINUX="cgroup_enable=memory swapaccount=1"'
    FILEPATH="/etc/default/grub"
    sed -i "s;$SEARCH;$REPLACE;" $FILEPATH
    update-grub
  EOH
end
