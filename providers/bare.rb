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

def git_repo_exist?(repo_path)
  shell_out(
    "git rev-parse --resolve-git-dir '#{repo_path.delete("'")}'",
    user: node['git-ssh-server']['user'],
    group: node['git-ssh-server']['group']
  ).status.success?
end

action :create do
  name = new_resource.name.sub(/[.]git$/, '')
  base_path = new_resource.base_path || node['git-ssh-server']['base_path']
  repo_path = ::File.join(base_path, "#{name}.git")

  unless git_repo_exist?(repo_path) # ~FC023
    converge_by("Create #{new_resource}") do
      execute "git init --bare #{name}" do
        command "git init --bare '#{repo_path.delete("'")}'"
        user node['git-ssh-server']['user']
        group node['git-ssh-server']['group']
        # Fix: fatal: unable to access '/home/vagrant/.config/git/config':
        # Permission denied
        environment 'HOME' => node['git-ssh-server']['base_path']
      end
    end
  end

  post_update_path = ::File.join(repo_path, 'hooks', 'post-update')
  cookbook_file post_update_path do # ~FC021
    source 'post-update'
    cookbook 'git-ssh-server'
    action :create_if_missing
    mode 0755
    user node['git-ssh-server']['user']
    group node['git-ssh-server']['group']
    only_if { new_resource.add_update_server_hook }
  end
end
