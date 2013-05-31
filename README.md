Description
===========

Configures a basic git repository container to be accesed through ssh.

Requirements
============

## Platform:

* Amazon
* Arch
* Centos
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
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td><code>node['git-repo']['base_path']</code></td>
    <td>Git repository base path</td>
    <td><i>calculated</i></td>
  </tr>
  <tr>
    <td><code>node['git-repo']['user']</code></td>
    <td>System user used to manage the repositories</td>
    <td><code>git</code></td>
  </tr>
  <tr>
    <td><code>node['git-repo']['group']</code></td>
    <td>System group used to manage the repositories</td>
    <td><code>git</code></td>
  </tr>
  <tr>
    <td><code>node['git-repo']['shell']</code></td>
    <td>Git user shell</td>
    <td><code>/usr/bin/git-shell</code></td>
  </tr>
  <tr>
    <td><code>node['git-repo']['hostname']</code></td>
    <td>Machine hostname, used only in the README template</td>
    <td><i>calculated</i></td>
  </tr>
</table>

Recipes
=======

## git-repo::default

Configures a git repository container

Resources
=========

## git_repo_bare[name]

Creates a new bare repostiory.

### git_repo_bare actions

* `create`: Creates a bare respository (default).

### git_repo_bare attributes

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td>name</td>
    <td>Repository name</td>
    <td><i>resource name</i></td>
  </tr>
  <tr>
    <td>base_path</td>
    <td>Git repository base path</td>
    <td><code>node['git-repo']['base_path']</code></td>
  </tr>
</table>

### git_repo_bare example

```ruby
git_repo_bare 'library1'

git_repo_bare 'webapp1'
```

## git_repo_ssh_key[keyname]

Grant access to an SSH key to all the repositories.

### git_repo_ssh_key actions

* `add`: adds an SSH key (default).

### git_repo_ssh_key attributes

<table>
  <tr>
    <td>Attribute</td>
    <td>Description</td>
    <td>Default</td>
  </tr>
  <tr>
    <td>keyname</td>
    <td>SSH key name</td>
    <td><i>resource name</i></td>
  </tr>
  <tr>
    <td>key</td>
    <td>SSH RSA public key value</td>
    <td><i>required</i></td>
  </tr>
  <tr>
    <td>keytype</td>
    <td>SSH RSA key type</td>
    <td><code>ssh-rsa</code></td>
  </tr>
  <tr>
    <td>base_path</td>
    <td>Git repository base path</td>
    <td><code>node['git-repo']['base_path']</code></td>
  </tr>
</table>

### git_repo_ssh_key example

```ruby
# the SSH public key from your ~/.ssh/*.pub file
git_repo_ssh_key 'battle-laptop' do
  key 'AAAAB3NzaC1yc2EAAAABIwAAAQEA[...]'
end
```

Testing
=======

## Requirements

* `vagrant`
* `berkshelf` >= `1.4.0`
* `test-kitchen` >= `1.0.0.alpha`
* `kitchen-vagrant` >= `0.10.0`

## Running the tests

``bash
$ kitchen test
``

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

