# encoding: UTF-8
#
# Cookbook Name:: git-ssh-server
# Recipe:: default
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Xabier de Zuazo
# Copyright:: Copyright (c) 2013-2014 Onddo Labs, SL.
# License:: Apache License, Version 2.0
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

include_recipe 'git'

if node['git-ssh-server']['base_path'].nil?
  node.default['git-ssh-server']['base_path'] =
    node['git']['server']['base_path']
end

user node['git-ssh-server']['user'] do
  comment 'Git repository management user'
  home node['git-ssh-server']['base_path']
  shell node['git-ssh-server']['shell']
  system true
end

group node['git-ssh-server']['group'] do
  members node['git-ssh-server']['user']
  system true
  append true
end

directory node['git-ssh-server']['base_path'] do
  owner node['git-ssh-server']['user']
  group node['git-ssh-server']['group']
  mode '00750'
  recursive true
end

directory "#{node['git-ssh-server']['base_path']}/git-shell-commands" do
  owner node['git-ssh-server']['user']
  group node['git-ssh-server']['group']
  mode '00750'
  recursive true
end

template "#{node['git-ssh-server']['base_path']}/README.md" do
  owner node['git-ssh-server']['user']
  group node['git-ssh-server']['group']
  mode '00640'
  variables(
    hostname: node['git-ssh-server']['hostname'],
    user: node['git-ssh-server']['user'],
    base_path: node['git-ssh-server']['base_path']
  )
end
