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

describe 'git_ssh_server_ssh_key definition' do
  let(:chef_runner) { ChefSpec::SoloRunner.new }
  let(:chef_run) { chef_runner.converge('git-ssh-server_test') }

  context 'git-ssh-server_test recipe' do
    it 'adds me@foobar.com SSH key' do
      expect(chef_run).to render_file('/srv/git/.ssh/authorized_keys')
        .with_content(%r{^ssh-rsa [A-Za-z0-9+/=]+ me@foobar\.com$})
    end

    it 'adds you@foobar.com SSH key' do
      expect(chef_run).to render_file('/srv/git/.ssh/authorized_keys')
        .with_content(%r{^ssh-rsa [A-Za-z0-9+/=]+ you@foobar\.com$})
    end

    it 'adds superboss SSH key' do
      expect(chef_run).to render_file('/srv/git/.ssh/authorized_keys')
        .with_content(%r{^ssh-dss [A-Za-z0-9+/=]+ superboss$})
    end
  end # context git-ssh-server_test recipe
end # describe git_ssh_server_ssh_key definition
