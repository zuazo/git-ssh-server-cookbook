Git SSH Server Cookbook
=======================
[![Cookbook Version](https://img.shields.io/cookbook/v/git-ssh-server.svg?style=flat)](https://supermarket.chef.io/cookbooks/git-ssh-server)
[![GitHub Source](https://img.shields.io/badge/source-GitHub-blue.svg?style=flat)](https://github.com/zuazo/git-ssh-server-cookbook)
[![Dependency Status](http://img.shields.io/gemnasium/zuazo/git-ssh-server-cookbook.svg?style=flat)](https://gemnasium.com/zuazo/git-ssh-server-cookbook)
[![Build Status](http://img.shields.io/travis/zuazo/git-ssh-server-cookbook/1.0.0.svg?style=flat)](https://travis-ci.org/zuazo/git-ssh-server-cookbook)

[Chef](https://www.chef.io/) cookbook to set up a basic git repository container to be accessed via SSH.

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon Linux
* Arch
* CentOS
* Debian
* Fedora
* FreeBSD
* OpenSUSE
* Oracle Linux
* RedHat
* Scientific Linux
* SUSE
* Ubuntu
* Windows

Please, [let us know](https://github.com/zuazo/git-ssh-server-cookbook/issues/new?title=I%20have%20used%20it%20successfully%20on%20...) if you use it successfully on any other platform.

## Required Cookbooks

* [git](https://supermarket.chef.io/cookbooks/git)
* [ssh_authorized_keys](https://supermarket.chef.io/cookbooks/ssh_authorized_keys)

## Required Applications

* Ruby `1.9.3` or higher.

Attributes
==========

| Attribute                             | Default                | Description                    |
|:--------------------------------------|:-----------------------|:-------------------------------|
| `node['git-ssh-server']['base_path']` | *calculated*           | Git repository base path.
| `node['git-ssh-server']['user']`      | `'git'`                | System user used to manage the repositories.
| `node['git-ssh-server']['group']`     | `'git'`                | System group used to manage the repositories.
| `node['git-ssh-server']['shell']`     | `'/usr/bin/git-shell'` | Git user shell.
| `node['git-ssh-server']['hostname']`  | *calculated*           | Machine hostname, used only in the README template.

Recipes
=======

## git-ssh-server::default

Configures a git repository container

Resources
=========

## git_ssh_server_bare[name]

Creates a new bare repository.

### git_ssh_server_bare Actions

* `create`: Creates a bare repository (default).

### git_ssh_server_bare Parameters

| Parameters             | Default         | Description                    |
|:-----------------------|:----------------|:-------------------------------|
| name                   | *resource name* | Repository name.
| base_path              | *calculated*    | Git repository base path.
| add_update_server_hook | `false`         | Create the post-update-hook with `exec git update-server-info` (`true` or `false`).

### git_ssh_server_bare Example

```ruby
git_ssh_server_bare 'library1'

git_ssh_server_bare 'webapp1' do
  add_update_server_hook true
end
```

Definitions
===========

## git_ssh_server_ssh_key[keyname]

Grant access to a SSH key to all the repositories.

### git_ssh_server_ssh_key Parameters

| Parameters | Default         | Description              |
|:-----------|:----------------|:-------------------------|
| keyname    | *resource name* | SSH key name.
| key        | *required*      | SSH RSA public key value.
| keytype    | `'ssh-rsa'`     | SSH RSA key type.
| base_path  | *calculated*    | Git repository base path.

### git_ssh_server_ssh_key Example

```ruby
# the SSH public key from your ~/.ssh/*.pub file
git_ssh_server_ssh_key 'battle-laptop' do
  key 'AAAAB3NzaC1yc2EAAAABIwAAAQEA[...]'
end
```

Usage Example
=============

## Including in a Cookbook Recipe

```ruby
include_recipe 'git-ssh-server::default' # or put it in your run_list

git_ssh_server_bare 'my-library-one'
git_ssh_server_bare 'my-library-two'
git_ssh_server_bare 'my-webapp'

git_ssh_server_ssh_key 'my-laptop-key' do
  key(
    'AAAAB3NzaC1yc2EAAAADAQABAAABAQDjvOJeZHLa15iajIat6YxtDM2BtVwxZ/WMIcGh6NeQB'\
    'I1Nhs4nIpHRCC5bOG4Pg5d6QYaFLDXHx7rHWzprBMi7XuBANGUKESFemByF2DU7hO60/DhA+K'\
    'mzeEkCVIqGTh+G7GFucjNGvJgles7MjkOenIc7Xb+OXKcPdTRpQslwJErsIqb1EfRT+8kZvVn'\
    '9d9RBS9grWkiOz+d+SVU/D6S40st2f4VDE5NHxcA9/U0vT7tLvC+G6lNJ4+w8M1jpvTDosKeq'\
    'yfqQnucf61VWc6ClGh8p88WTSZ081jGB0OkM+nFBsOtzJ+Gmy/N2I+eJGjTykAC7MvLPUsQjA'\
    '0KYsZRL'
  )
end

git_ssh_server_ssh_key 'another-developer' do
  key(
    'AAAAB3NzaC1yc2EAAAADAQABAAABAQC75j5iuOWD2Xqw/hKVoJ32n0r6jRjlBofjtEkFDknZp'\
    'CMG3whdy64FGNvYYgoajLOc/TyhF+ntt/Go3CrasxNhEusnj6HQu57d0nAnnTleDBHLgcCxFW'\
    'QrGTXpop+JziHYXpZHT5bvMV0zfw0C6ezheUnlXlA5+2JNZx3JwhfZqu0L18iwOdWzWbL3zta'\
    'D84l0e030JTyg6SP/feXvM5bnQpySCWnqk6L2yzhXQh3tpg95l/8srSE1tuRwgWx4gW2k0E9x'\
    'gWtDwcx4lsskMdti6vZ/aM4Ll/jTFAO0hmXZEDnsSr0NEuwm/n8jvN9qwHPLBsk2YWf57VPKq'\
    'VQ2rYLx'
  )
end
```

Don't forget to include the `git-ssh-server` cookbook as a dependency in the metadata.

```ruby
# metadata.rb
# [...]

depends 'git-ssh-server'
```

## Including in the Run List

Another alternative is to include the default recipe in your *Run List*.

```json
{
  "name": "git.example.com",
  "[...]": "[...]",
  "run_list": [
    "[...]",
    "recipe[git-ssh-server]"
  ]
}
```

Testing
=======

See [TESTING.md](https://github.com/zuazo/git-ssh-server-cookbook/blob/master/TESTING.md).

## ChefSpec Matchers

### git_ssh_server_bare(name)

Helper method for locating a `git_ssh_server_bare` resource in the collection.

```ruby
resource = chef_run.git_ssh_server_bare(name)
expect(resource).to notify('service[apache2]').to(:reload)
```

### create_git_ssh_server_bare(name)

Assert that the *Chef Run* creates a bare repository in the Git SSH Server.

```ruby
expect(chef_run).to create_git_ssh_server_bare(name)
```

### ChefSpec Matchers for the `git_ssh_server_ssh_key` Definition

To create ChefSpec tests for the `git_ssh_server_ssh_key` definition, you can use the [`render_file`](http://www.rubydoc.info/github/sethvargo/chefspec#render_file) matcher to check the *authorized_keys* file content:

```ruby
it 'allows bob to access git repositories' do
  expect(chef_run).to render_file('/srv/git/.ssh/authorized_keys')
    .with_content(/^ssh-rsa [A-Za-z0-9+\/=]+ bob@acme\.com$/)
end
```

You can also test against the internal template:

```ruby
it 'creates /srv/git/.ssh/authorized_keys file' do
  expect(chef_run).to create_template('/srv/git/.ssh/authorized_keys')
end
```

Contributing
============

Please do not hesitate to [open an issue](https://github.com/zuazo/git-ssh-server-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/zuazo/git-ssh-server-cookbook/blob/master/CONTRIBUTING.md).

License and Author
==================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Raúl Rodríguez (<raul@onddo.com>)
| **Author:**          | Xabier de Zuazo (<xabier@zuazo.org>)
| **Contributor:**     | [Arnold Krille](https://github.com/kampfschlaefer)
| **Copyright:**       | Copyright (c) 2015, Xabier de Zuazo
| **Copyright:**       | Copyright (c) 2013 Onddo Labs, SL.
| **License:**         | Apache License, Version 2.0

    Licensed under the Apache License, Version 2.0 (the "License");
    you may not use this file except in compliance with the License.
    You may obtain a copy of the License at
    
        http://www.apache.org/licenses/LICENSE-2.0
    
    Unless required by applicable law or agreed to in writing, software
    distributed under the License is distributed on an "AS IS" BASIS,
    WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
    See the License for the specific language governing permissions and
    limitations under the License.
