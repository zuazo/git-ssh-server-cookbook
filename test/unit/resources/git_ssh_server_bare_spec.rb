# encoding: UTF-8
#
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

require_relative '../spec_helper'

describe 'git_ssh_server_bare resource' do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge('git-ssh-server_test') }

  context 'git-ssh-server_test recipe' do
    it 'includes git-ssh-server recipe' do
      expect(chef_run).to include_recipe('git-ssh-server')
    end

    it 'creates base_path directory' do
      expect(chef_run).to create_directory('/srv/git')
    end

    it 'creates git-shell-commands directory' do
      expect(chef_run).to create_directory('/srv/git/git-shell-commands')
    end

    it 'creates README file' do
      expect(chef_run).to render_file('/srv/git/README.md')
    end

    context 'using resource matchers' do
      it 'creates repo1 bare repository' do
        expect(chef_run).to create_git_ssh_server_bare('repo1')
      end

      it 'creates repo2 bare repository' do
        expect(chef_run).to create_git_ssh_server_bare('repo2')
      end

      it 'creates app3 bare repository' do
        expect(chef_run).to create_git_ssh_server_bare('app3')
      end
    end # context using resource matchers

    context 'step into the resource' do
      let(:chef_runner) do
        ChefSpec::SoloRunner.new(step_into: %w(git_ssh_server_bare))
      end
      let(:shell_out) { instance_double('Mixlib::ShellOut') }
      let(:proc_status) { instance_double('Process::Status') }
      let(:repos) { %w(repo1 repo2 app3) }
      before do
        allow_any_instance_of(Chef::Mixin::ShellOut).to receive(:shell_out)
          .and_call_original
        repos.each do |repo|
          allow_any_instance_of(Chef::Mixin::ShellOut).to receive(:shell_out)
            .with(
              "git rev-parse --resolve-git-dir '/srv/git/#{repo}.git'",
              user: 'git', group: 'git'
            )
            .and_return(shell_out)
          allow(shell_out).to receive(:status).and_return(proc_status)
          allow(proc_status).to receive(:success?).and_return(false)
        end
      end

      it 'creates repo1 bare repository' do
        expect(chef_run).to run_execute('git init --bare repo1')
          .with_command("git init --bare '/srv/git/repo1.git'")
          .with_user('git')
          .with_group('git')
          .with_environment('HOME' => '/srv/git')
      end

      it 'creates repo2 bare repository' do
        expect(chef_run).to run_execute('git init --bare repo2')
      end

      it 'creates app3 bare repository' do
        expect(chef_run).to run_execute('git init --bare app3')
      end

      it 'does not create repo1 update hook' do
        expect(chef_run)
          .to_not create_cookbook_file_if_missing(
            '/srv/git/repo1.git/hooks/post-update'
          )
      end

      it 'creates repo2 update hook' do
        expect(chef_run)
          .to create_cookbook_file_if_missing(
            '/srv/git/repo2.git/hooks/post-update'
          )
          .with_source('post-update')
          .with_cookbook('git-ssh-server')
          .with_user('git')
          .with_group('git')
      end

      it 'does not create app3 update hook' do
        expect(chef_run)
          .to_not create_cookbook_file_if_missing(
            '/srv/git/app3.git/hooks/post-update'
          )
      end

      context 'when the repositories already exists' do
        before { allow(proc_status).to receive(:success?).and_return(true) }

        it 'does not create repo1 bare repository' do
          expect(chef_run).to_not run_execute('git init --bare repo1')
        end

        it 'does not create repo2 bare repository' do
          expect(chef_run).to_not run_execute('git init --bare repo2')
        end

        it 'does not create app3 bare repository' do
          expect(chef_run).to_not run_execute('git init --bare app3')
        end
      end
    end # context step into the resource
  end # context git-ssh-server_test recipe
end # describe git_ssh_server_bare resource
