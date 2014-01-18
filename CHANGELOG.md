# CHANGELOG for git-ssh-server

This file is used to list changes made in each version of `git-ssh-server` cookbook.

## 0.2.0:

* Add update server hook ([issue #1](https://github.com/onddo/git-ssh-server-cookbook/pull/1), thanks [Arnold Krille](https://github.com/kampfschlaefer))

## 0.1.3:

* fix: bare repositories do not have .git dir
* git_ssh_server_bare LWRP notify only when the action is executed

## 0.1.2:

* metadata: provides without square brackets to avoid [CHEF-3976](https://tickets.opscode.com/browse/CHEF-3976)

## 0.1.2:

* metadata: provides without square brackets to avoid [CHEF-3976](https://tickets.opscode.com/browse/CHEF-3976)

## 0.1.1:

* metadata: added minimum git cookbook version in depends
* ssh_key LWRP default action fixed (:add)

## 0.1.0:

* Initial release of `git-ssh-server`

