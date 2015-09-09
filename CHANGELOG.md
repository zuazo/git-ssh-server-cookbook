# CHANGELOG for git-ssh-server

This file is used to list changes made in each version of `git-ssh-server` cookbook.

## v0.3.0 (2014-11-16)

* Activate the post-update hook when the param is true ([issue #3](https://github.com/onddo/git-ssh-server-cookbook/pull/3), thanks [Arnold Krille](https://github.com/kampfschlaefer)).
* `git_ssh_server_bare`: change user/group in `shell_out` command.
* Add FreeBSD support.
* Add ChefSpec tests for git-ssh-server::default recipe.
* Enable ChefSpec coverage.
* providers/bare: ignore FC023 rule.
* Gemfile:
 * Move test-kitchen gems to `:integration` group.
 * Fix *Illformed requirement in "berkshelf"*.
* Add travis.yml file.
* Test for the update-hook ([issue #2](https://github.com/onddo/git-ssh-server-cookbook/pull/2), thanks [Arnold Krille](https://github.com/kampfschlaefer)).
* Update tests: add Gemfile, Berksfile and Rakefile templates.
* Update kitchen.yml file.
* Move *test/kitchen/cookbooks* to *test/cookbooks*.
* README:
 * Split in multiple files.
 * Add multiple badges.
 * Fixes and improvements.

## v0.2.0 (2014-01-18)

* Add update server hook ([issue #1](https://github.com/onddo/git-ssh-server-cookbook/pull/1), thanks [Arnold Krille](https://github.com/kampfschlaefer)).

## v0.1.3 (2013-11-17)

* Fix: bare repositories do not have .git dir.
* `git_ssh_server_bare` LWRP notify only when the action is executed.

## v0.1.2 (2013-10-28)

* metadata: provides without square brackets to avoid [CHEF-3976](https://tickets.chef.io/browse/CHEF-3976).

## v0.1.1 (2013-08-15)

* metadata: Add minimum git cookbook version in depends.
* Fix `git_ssh_server_ssh_key` LWRP default action (`:add`).

## v0.1.0 (2013-06-08)

* Initial release of `git-ssh-server`.
