# encoding: UTF-8
#
# Cookbook Name:: git-ssh-server
# Provider:: bare
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

require 'chef/mixin/shell_out'
include Chef::Mixin::ShellOut

def whyrun_supported?
  true
end

action :create do
  name = new_resource.name.sub(/[.]git$/, '')
  base_path = new_resource.base_path || node['git-ssh-server']['base_path']

  unless shell_out( # ~FC023
           "git rev-parse --resolve-git-dir '#{base_path}/#{name}.git'",
           {
             :user => node['git-ssh-server']['user'],
             :group => node['git-ssh-server']['group']
           }).status.success?
    converge_by("Create #{new_resource}") do
      execute "git init --bare #{name}" do
        command "git init --bare '#{base_path}/#{name}.git'"
        user node['git-ssh-server']['user']
        group node['git-ssh-server']['group']
      end
    end
  end

  cookbook_file "#{base_path}/#{name}.git/hooks/post-update" do
    source "post-update"
    cookbook "git-ssh-server"
    action :create_if_missing
    mode 0755
    user node['git-ssh-server']['user']
    group node['git-ssh-server']['group']
    only_if { new_resource.add_update_server_hook }
  end
end
