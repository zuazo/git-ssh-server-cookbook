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

require_relative 'spec_helper'

describe 'Repositories' do
  describe 'repository directories' do
    describe file('/srv/git/repo1.git') do
      it { should be_directory }
    end

    describe file('/srv/git/repo2.git') do
      it { should be_directory }
    end

    describe file('/srv/git/app3.git') do
      it { should be_directory }
    end
  end

  describe 'repository objects' do
    describe file('/srv/git/repo1.git/objects') do
      it { should be_directory }
    end

    describe file('/srv/git/repo2.git/objects') do
      it { should be_directory }
    end

    describe file('/srv/git/app3.git/objects') do
      it { should be_directory }
    end
  end

  describe 'update hooks' do
    describe file('/srv/git/repo1.git/hooks/post-update') do
      it { should_not be_file }
    end

    describe file('/srv/git/repo2.git/hooks/post-update') do
      it { should be_file }
    end

    describe file('/srv/git/app3.git/hooks/post-update') do
      it { should_not be_file }
    end
  end

  describe 'valid repositories' do
    describe command('cd /srv/git/repo1.git/ && git branch') do
      its(:exit_status) { should eq 0 }
    end

    describe command('cd /srv/git/repo2.git/ && git branch') do
      its(:exit_status) { should eq 0 }
    end

    describe command('cd /srv/git/app3.git/ && git branch') do
      its(:exit_status) { should eq 0 }
    end
  end

  describe 'clone repositories' do
    describe command(
              'rm -rf /tmp/repo1 && git clone /srv/git/repo1.git /tmp/repo1'
             ) do
      its(:exit_status) { should eq 0 }
    end

    describe command(
              'rm -rf /tmp/repo2 && git clone /srv/git/repo2.git /tmp/repo2'
             ) do
      its(:exit_status) { should eq 0 }
    end

    describe command(
              'rm -rf /tmp/app3 && git clone /srv/git/app3.git /tmp/app3'
             ) do
      its(:exit_status) { should eq 0 }
    end
  end
end
