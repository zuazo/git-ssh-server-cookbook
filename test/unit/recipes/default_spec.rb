# encoding: UTF-8
#
# Author:: Xabier de Zuazo (<xabier@zuazo.org>)
# Copyright:: Copyright (c) 2015 Xabier de Zuazo
# Copyright:: Copyright (c) 2014 Onddo Labs, SL.
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

require_relative '../spec_helper'

describe 'git-ssh-server::default' do
  let(:base_path) { '/var/git_base_path' }
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge(described_recipe) }
  let(:node) { chef_runner.node }
  before { node.set['git-ssh-server']['base_path'] = base_path }

  it 'includes git recipe' do
    expect(chef_run).to include_recipe('git')
  end

  it 'calculates base_path attribute when not set' do
    node.set['git-ssh-server']['base_path'] = nil
    node.set['git']['server']['base_path'] = base_path
    chef_run
    expect(node['git-ssh-server']['base_path']).to eq(base_path)
  end

  it 'does not calculate base_path attribute when set' do
    node.set['git-ssh-server']['base_path'] = base_path # not needed
    node.set['git']['server']['base_path'] = 'base_path_ignored'
    chef_run
    expect(node['git-ssh-server']['base_path']).to eq(base_path)
  end

  it 'creates git user' do
    expect(chef_run).to create_user('git')
      .with_comment('Git repository management user')
      .with_home(base_path)
      .with_shell('/usr/bin/git-shell')
      .with_system(true)
  end

  it 'creates git group' do
    expect(chef_run).to create_group('git')
      .with_members(%w(git))
      .with_system(true)
      .with_append(true)
  end

  it 'creates base path directory' do
    expect(chef_run).to create_directory(base_path)
      .with_owner('git')
      .with_group('git')
      .with_mode('00750')
      .with_recursive(true)
  end

  it 'creates git-shell-command directory' do
    expect(chef_run).to create_directory("#{base_path}/git-shell-commands")
      .with_owner('git')
      .with_group('git')
      .with_mode('00750')
      .with_recursive(true)
  end

  it 'creates a README.md file' do
    expect(chef_run).to create_template("#{base_path}/README.md")
      .with_owner('git')
      .with_group('git')
      .with_mode('00640')
  end
end
