# encoding: UTF-8
#
# Cookbook Name:: git-ssh-server
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

name 'git-ssh-server'
maintainer 'Xabier de Zuazo'
maintainer_email 'xabier@zuazo.org'
license 'Apache 2.0'
description 'Set up a basic git repository container to be accesed via SSH.'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version '1.0.0'

if respond_to?(:source_url)
  source_url "https://github.com/zuazo/#{name}-cookbook"
end
if respond_to?(:issues_url)
  issues_url "https://github.com/zuazo/#{name}-cookbook/issues"
end

depends 'git', '>= 2.2.0'
depends 'ssh_authorized_keys', '~> 0.3'

supports 'amazon'
supports 'arch'
supports 'centos'
supports 'debian'
supports 'fedora'
supports 'mac_os_x', '>= 10.6.0'
supports 'opensuse'
supports 'oracle'
supports 'redhat'
supports 'scientific'
supports 'suse'
supports 'ubuntu'
supports 'windows'

recipe 'git-ssh-server::default', 'Configures a git repository container.'

provides 'git_ssh_server_bare'
provides 'git_ssh_server_ssh_key'
# Commented until 11.0.10 server release (CHEF-3976)
# provides 'git_ssh_server_bare[name]'
# provides 'git_ssh_server_ssh_key[keyname]'

attribute 'git-ssh-server/base_path',
          display_name: 'Base path',
          description: 'Git server base path.',
          calculated: true,
          type: 'string',
          required: 'optional'

attribute 'git-ssh-server/user',
          display_name: 'System user',
          description: 'System user used to manage the repositories.',
          type: 'string',
          required: 'optional',
          default: '"git"'

attribute 'git-ssh-server/group',
          display_name: 'System group',
          description: 'System group used to manage the repositories.',
          type: 'string',
          required: 'optional',
          default: '"git"'

attribute 'git-ssh-server/shell',
          display_name: 'Git user shell',
          description: 'Git user shell.',
          type: 'string',
          required: 'optional',
          default: '"/usr/bin/git-shell"'

attribute 'git-ssh-server/hostname',
          display_name: 'Machine hostname',
          description: 'Machine hostname, used only in the README template.',
          calculated: true,
          type: 'string',
          required: 'recommended'
