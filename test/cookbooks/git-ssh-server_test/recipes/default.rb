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
  key(
    'AAAAB3NzaC1yc2EAAAADAQABAAABAQDjvOJeZHLa15iajIat6YxtDM2BtVwxZ/WMIcGh6NeQB'\
    'I1Nhs4nIpHRCC5bOG4Pg5d6QYaFLDXHx7rHWzprBMi7XuBANGUKESFemByF2DU7hO60/DhA+K'\
    'mzeEkCVIqGTh+G7GFucjNGvJgles7MjkOenIc7Xb+OXKcPdTRpQslwJErsIqb1EfRT+8kZvVn'\
    '9d9RBS9grWkiOz+d+SVU/D6S40st2f4VDE5NHxcA9/U0vT7tLvC+G6lNJ4+w8M1jpvTDosKeq'\
    'yfqQnucf61VWc6ClGh8p88WTSZ081jGB0OkM+nFBsOtzJ+Gmy/N2I+eJGjTykAC7MvLPUsQjA'\
    '0KYsZRL'
  )
  action :add
end

git_ssh_server_ssh_key 'you@foobar.com' do
  key(
    'AAAAB3NzaC1yc2EAAAADAQABAAABAQC75j5iuOWD2Xqw/hKVoJ32n0r6jRjlBofjtEkFDknZp'\
    'CMG3whdy64FGNvYYgoajLOc/TyhF+ntt/Go3CrasxNhEusnj6HQu57d0nAnnTleDBHLgcCxFW'\
    'QrGTXpop+JziHYXpZHT5bvMV0zfw0C6ezheUnlXlA5+2JNZx3JwhfZqu0L18iwOdWzWbL3zta'\
    'D84l0e030JTyg6SP/feXvM5bnQpySCWnqk6L2yzhXQh3tpg95l/8srSE1tuRwgWx4gW2k0E9x'\
    'gWtDwcx4lsskMdti6vZ/aM4Ll/jTFAO0hmXZEDnsSr0NEuwm/n8jvN9qwHPLBsk2YWf57VPKq'\
    'VQ2rYLx'
  )
  action :add
end

git_ssh_server_ssh_key 'superboss' do
  key(
    'AAAAB3NzaC1kc3MAAACBAKaQH2W32pK5P9Tf7pz5u+qRKzI2mwAOP4/1D6mPWw9/y0JZ5RWWA'\
    'IJ1S7QUAZhaOkZpsAQwqlWKfZaD31HRpryT29mg/RpdEsYWSEq230qJglbco/sSNLjOcuvaEZ'\
    'I4eJiJIBvF8yMLROl2gpIQWBOAL05vLcPjdOuSZzkJXJHbAAAAFQD1DhsC64Wpad6T9Qia/l/'\
    'Fp+WeUQAAAIAq8wxrYgxpjqnSJTrzXoTqULb1cIKc0hZmr67MWPkGDL8T8KxX+ZmX3KCqezPD'\
    'QHgb1//Wtxm7YOPEgC0EEojO7Ln4eV5HztAqTF7qBIsVbc4TiZ2QkI4brZHpTp2u6xjR13rK3'\
    '2FeoTGRolF5Ikmzqg8OkvUwAkfM6naQE2l4NgAAAIEAi5AteXRE7I4aRQnb7li+98JZkOtSAs'\
    'A5U1aOzgenLH+C9TitJVdPQNhvzbxpsXqCoklBSqYo1O90WrsQjlTRVEKJLTz1XnKRU6uLMLC'\
    '1Q4vV4FreSQ+dE7iGYooFw8cnLbXayzVau7AlVKu/vzQQeNCG/Doo/W2FdRYkJuu73H8='
  )
  keytype 'ssh-dss'
  action :add
end
