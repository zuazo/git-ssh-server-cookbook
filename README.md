Git SSH Server Cookbook
=======================
[![Cookbook Version](https://img.shields.io/cookbook/v/git-ssh-server.svg?style=flat)](https://supermarket.chef.io/cookbooks/git-ssh-server)
[![Dependency Status](http://img.shields.io/gemnasium/zuazo/git-ssh-server-cookbook.svg?style=flat)](https://gemnasium.com/zuazo/git-ssh-server-cookbook)
[![Build Status](http://img.shields.io/travis/zuazo/git-ssh-server-cookbook.svg?style=flat)](https://travis-ci.org/zuazo/git-ssh-server-cookbook)

[Chef](https://www.chef.io/) cookbook to set up a basic git repository container to be accessed via SSH.

Requirements
============

## Supported Platforms

This cookbook has been tested on the following platforms:

* Amazon
* Arch
* CentOS
* Debian
* Fedora
* FreeBSD
* RedHat
* Scientific
* Ubuntu

Please, [let us know](https://github.com/zuazo/git-ssh-server-cookbook/issues/new?title=I%20have%20used%20it%20successfully%20on%20...) if you use it successfully on any other platform.

## Required Cookbooks

* [git](https://supermarket.chef.io/cookbooks/git)

Attributes
==========

| Attribute                             | Default                | Description                    |
|:--------------------------------------|:-----------------------|:-------------------------------|
| `node['git-ssh-server']['base_path']` | *calculated*           | Git repository base path
| `node['git-ssh-server']['user']`      | `'git'`                | System user used to manage the repositories
| `node['git-ssh-server']['group']`     | `'git'`                | System group used to manage the repositories
| `node['git-ssh-server']['shell']`     | `'/usr/bin/git-shell'` | Git user shell
| `node['git-ssh-server']['hostname']`  | *calculated*           | Machine hostname, used only in the README template

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
| name                   | *resource name* | Repository name
| base_path              | *calculated*    | Git repository base path
| add_update_server_hook | false           | Create the post-update-hook with `exec git update-server-info` [true/false]

### git_ssh_server_bare Example

```ruby
git_ssh_server_bare 'library1'

git_ssh_server_bare 'webapp1' do
  add_update_server_hook true
end
```

## git_ssh_server_ssh_key[keyname]

Grant access to an SSH key to all the repositories.

### git_ssh_server_ssh_key Actions

* `add`: adds an SSH key (default).

### git_ssh_server_ssh_key Parameters

| Parameters | Default         | Description              |
|:-----------|:----------------|:-------------------------|
| keyname    | *resource name* | SSH key name
| key        | *required*      | SSH RSA public key value
| keytype    | `"ssh-rsa"`     | SSH RSA key type
| base_path  | *calculated*    | Git repository base path

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
  key 'AAAAB3NzaC1yc2EAAAABIwAAAQEAv8lgaVb1BtGTLZG2cwc8WQF/X2Mxcuu/UPxN3yT6VQuFa6zl/LbSMND9OADS6ULw6p0hnWPnRDA8rSJvdcYO7pTSJOclScEuIMm4Nx8c3uhfePF/o39QPhH3WAyee/SFDay430Y11W5ZuOXuZ7Wb2PQEPUaQxs9k/MUHjIIcNLS7qG/FP5IGAb0df9KkAnSGXTgZ/Z9Xh+4mAkoBkXIr99oZsphF/PcxcVQfq4V6dTg81LUPLfaSj6U8gXmjRpRYNgk5uEdci7loKDmv1EPKhzwsJIEp9wxpAJqel5sezHaYN5w3zplbr7UY1+YuEBn2jnYhzbdBZcVDmL1D5F/G+Q=='
end

git_ssh_server_ssh_key 'another-developer' do
  key 'AAAAB3NzaC1yc2EAAAABIwAAAQEAqFEaEEv9Fx+6Qv8LPoY+e9rsvaARGJJbvc7y2Tl73zoA6rB7VTxqoyV6mhG+ozRiB4i5g5andBCSDjDXPS0ycUQmiR2OrLZDUpf3uUhaeOO1SFjIbUyFdqy1MBkcmkDzBtXJ/qgn/ydUX59lT00AoPY4URVMt13uaI6GCWrsxRFX+Hxk5prVjoUqJQ7iSidXJ9CHksKTamgn3Ywc9w1MMYcegB+NVg0GsHDZMyq1PxFKGtqNS2PriQfoUrva76rolTej2rbnyH9drZZNi8lsxZ/Xi8ObjT68gc3OfswA64DRhQuN+aQT4bBK1xU+2AE88P9L2LSEYkekTzt7CElqrw=='
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

Contributing
============

Please do not hesitate to [open an issue](https://github.com/zuazo/git-ssh-server-cookbook/issues/new) with any questions or problems.

See [CONTRIBUTING.md](https://github.com/zuazo/git-ssh-server-cookbook/blob/master/CONTRIBUTING.md).

License and Author
=====================

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
