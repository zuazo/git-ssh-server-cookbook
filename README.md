Description
===========

Set up a basic git repository container to be accesed via ssh.

Requirements
============

## Platform:

* Amazon
* Arch
* CentOS
* Debian
* Fedora
* Redhat
* Scientific
* Ubuntu

## Cookbooks:

* git

Attributes
==========

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td><code>node['git-ssh-server']['base_path']</code></td>
    <td>Git repository base path</td>
    <td><em>calculated</em></td>
  </tr>
  <tr>
    <td><code>node['git-ssh-server']['user']</code></td>
    <td>System user used to manage the repositories</td>
    <td><code>"git"</code></td>
  </tr>
  <tr>
    <td><code>node['git-ssh-server']['group']</code></td>
    <td>System group used to manage the repositories</td>
    <td><code>"git"</code></td>
  </tr>
  <tr>
    <td><code>node['git-ssh-server']['shell']</code></td>
    <td>Git user shell</td>
    <td><code>"/usr/bin/git-shell"</code></td>
  </tr>
  <tr>
    <td><code>node['git-ssh-server']['hostname']</code></td>
    <td>Machine hostname, used only in the README template</td>
    <td><em>calculated</em></td>
  </tr>
</table>

Recipes
=======

## git-ssh-server::default

Configures a git repository container

Resources
=========

## git_ssh_server_bare[name]

Creates a new bare repostiory.

### git_ssh_server_bare actions

* `create`: Creates a bare respository (default).

### git_ssh_server_bare attributes

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>name</td>
    <td>Repository name</td>
    <td><em>resource name</em></td>
  </tr>
  <tr>
    <td>base_path</td>
    <td>Git repository base path</td>
    <td><code>node['git-ssh-server']['base_path']</code></td>
  </tr>
</table>

### git_ssh_server_bare example

```ruby
git_ssh_server_bare 'library1'

git_ssh_server_bare 'webapp1'
```

## git_ssh_server_ssh_key[keyname]

Grant access to an SSH key to all the repositories.

### git_ssh_server_ssh_key actions

* `add`: adds an SSH key (default).

### git_ssh_server_ssh_key attributes

<table>
  <tr>
    <th>Attribute</th>
    <th>Description</th>
    <th>Default</th>
  </tr>
  <tr>
    <td>keyname</td>
    <td>SSH key name</td>
    <td><em>resource name</em></td>
  </tr>
  <tr>
    <td>key</td>
    <td>SSH RSA public key value</td>
    <td><em>required</em></td>
  </tr>
  <tr>
    <td>keytype</td>
    <td>SSH RSA key type</td>
    <td><code>"ssh-rsa"</code></td>
  </tr>
  <tr>
    <td>base_path</td>
    <td>Git repository base path</td>
    <td><code>node['git-ssh-server']['base_path']</code></td>
  </tr>
</table>

### git_ssh_server_ssh_key example

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
[...]

depends 'git-ssh-server'
```

## Including in the Run List

Another alternative is to include the default recipe in your *Run List*.

```json
{
  "name": "git.onddo.com",
  [...]
  "run_list": [
    [...]
    "recipe[git-ssh-server]"
  ]
}
```

Testing
=======

## Requirements

* `vagrant`
* `berkshelf` >= `1.4.0`
* `test-kitchen` >= `1.0.0.alpha`
* `kitchen-vagrant` >= `0.10.0`

## Running the tests

```bash
$ kitchen test
$ kitchen verify
[...]
```

Contributing
============

1. Fork the repository on Github
2. Create a named feature branch (like `add_component_x`)
3. Write you change
4. Write tests for your change (if applicable)
5. Run the tests, ensuring they all pass
6. Submit a Pull Request using Github


License and Author
=====================

|                      |                                          |
|:---------------------|:-----------------------------------------|
| **Author:**          | Xabier de Zuazo (<xabier@onddo.com>)
| **Copyright:**       | Copyright (c) 2013 Onddo Labs, SL. (www.onddo.com)
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

