# encoding: UTF-8
#
# Cookbook Name:: git-ssh-server
# Definition:: git_ssh_server_ssh_key
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Xabier de Zuazo
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

define :git_ssh_server_ssh_key do
  base_path = params[:base_path] || node['git-ssh-server']['base_path']
  ssh_keyname = params[:keyname] || params[:name]
  ssh_key = params[:key]
  ssh_keytype = params[:keytype]

  r = ssh_authorize_key ssh_keyname do
    user node['git-ssh-server']['user']
    group node['git-ssh-server']['group']
    home base_path
    key ssh_key
    keytype ssh_keytype
  end

  # For notifications support (only works in Chef 12).
  # @example
  #   my_definition = git_ssh_server_ssh_key 'bob@acme.com' { ... }
  #   my_definition.notifies :run, 'execute[thing]'
  r
end
