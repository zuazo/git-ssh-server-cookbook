#
# Cookbook Name:: git-repo
# Recipe:: default
#
# Copyright 2013, Onddo Labs, Sl.
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

if node['git-repo']['base_path'].nil?
  node.default['git-repo']['base_path'] = node['git']['server']['base_path']
end

user node['git-repo']['user'] do
  comment 'Git repository management user'
  home node['git-repo']['base_path']
  shell node['git-repo']['shell']
  system true
end

group node['git-repo']['group'] do
  members node['git-repo']['user']
  system true
  append true
end

directory node['git-repo']['base_path'] do
  owner node['git-repo']['user']
  group node['git-repo']['group']
  mode '00750'
  recursive true
end

directory "#{node['git-repo']['base_path']}/git-shell-commands" do
  owner node['git-repo']['user']
  group node['git-repo']['group']
  mode '00750'
  recursive true
end

template "#{node['git-repo']['base_path']}/README.md" do
  owner node['git-repo']['user']
  group node['git-repo']['group']
  mode '00640'
  variables(
    :hostname => node['git-repo']['hostname'],
    :user => node['git-repo']['user'],
    :base_path => node['git-repo']['base_path']
  )
end

