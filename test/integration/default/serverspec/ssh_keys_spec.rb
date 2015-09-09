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

describe 'SSH Keys' do
  describe file('/srv/git/.ssh') do
    it { should be_directory }
    it { should be_mode 700 }
    it { should be_owned_by 'git' }
    it { should be_grouped_into 'git' }
  end

  describe file('/srv/git/.ssh/authorized_keys') do
    it { should be_file }
    it { should be_mode 600 }
    it { should be_owned_by 'git' }
    it { should be_grouped_into 'git' }
    its(:content) { should match(/^ssh-rsa\s+.*mzeEkCVIq.*\s+me@foobar\.com$/) }
    its(:content) { should match(/^ssh-rsa\s+.*QrGTXpo.*\s+you@foobar\.com$/) }
    its(:content) { should match(/^ssh-dss\s+.*I4eJiJIBvF8yML.*\s+superboss$/) }
  end
end
