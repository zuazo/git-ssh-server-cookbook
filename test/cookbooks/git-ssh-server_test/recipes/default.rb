# encoding: UTF-8
#
# Cookbook Name:: git-ssh-server_test
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

include_recipe 'git-ssh-server'

git_ssh_server_bare 'repo1'
git_ssh_server_bare 'repo2' do
  add_update_server_hook true
end
git_ssh_server_bare 'app3'

git_ssh_server_ssh_key 'me@foobar.com' do
  key 'AAABBBCCC'
  action :add
end

git_ssh_server_ssh_key 'you@foobar.com' do
  key 'DDDEEEFFF'
  action :add
end

git_ssh_server_ssh_key 'superboss' do
  key 'GGGHHHIII'
  keytype 'ssh-dsa'
  action :add
end
