# encoding: UTF-8
#
# Cookbook Name:: git-ssh-server
# Attributes:: default
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

# Get from `node['git']['server']['base_path']`
default['git-ssh-server']['base_path'] = nil

default['git-ssh-server']['user'] = 'git'
default['git-ssh-server']['group'] = 'git'
default['git-ssh-server']['shell'] = '/usr/bin/git-shell'
default['git-ssh-server']['hostname'] = node['fqdn']
