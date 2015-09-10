# CHANGELOG for git-ssh-server

This file is used to list changes made in each version of `git-ssh-server` cookbook.

## v1.0.0 (2015-09-10)

* **Breaking changes:**
 * Fix all RuboCop offenses:
  * Ruby `<= 1.9.2` compatibilty drop.
 * Convert the `git_ssh_server_ssh_key` resource to a definition using the [`ssh_authorized_keys`](https://supermarket.chef.io/cookbooks/ssh_authorized_keys) cookbook:
  * From the [`ssh_authorize_key`](https://github.com/zuazo/ssh_authorized_keys-cookbook#ssh_authorize_key) documentation:
    * This definition uses the [Accumulator Pattern](http://docs.chef.io/definitions.html#many-recipes-one-definition). This implies that any SSH key added using other methods (such as **keys added by hand**) will be **deleted**.
  * This may break resources calling the `git_ssh_server_ssh_key` resource. They will need to be converted to definitions for the accumulator pattern to work properly.

* Improvements:
 * Add OpenSUSE support.
 * Add ChefSpec matchers and locators.
 * Fix foodcritic offenses.
 * Update chef links to use *chef.io* domain.
 * Update contact information and links after migration.
 * metadata: Add `source_url` and `issues_url` links.

* Bug Fixes:
 * Fix CentOS `5` support: *fatal: unable to access /home/vagrant/.config/git/config: Permission denied*.

* Documentation:
 * Add LICENSE file.
 * Add license headers to code files.
 * README:
  * Use *Parameters* instead of *Properties*.
  * Improve title and description.
  * User markdown tables.
  * Add GitHub badge.

* Testing:
 * Replace bats tests by Serverspec tests.
 * Integrate [`should_not`](https://github.com/should-not/should_not) gem with the tests.
 * Update the Vagrantfile.
 * Move ChefSpec tests to *test/unit*.
 * Use `ChefSpec::SoloRunner` for tests.
 * Add ChefSpec tests for the `git_ssh_server_bare` resource and the `git_ssh_server_ssh_key` definition.
 * Update .kitchen.yml platforms.
 * Update some test related files: Gemfile, Guardfile, Rakefile, TESTING.md, ..
 * Add .kitchen.docker.yml file.
 * Integrate kitchen with Travis CI using `kitchen-in-travis` script.

## v0.3.0 (2014-11-16)

* Activate the post-update hook when the param is true ([issue #3](https://github.com/zuazo/git-ssh-server-cookbook/pull/3), thanks [Arnold Krille](https://github.com/kampfschlaefer)).
* `git_ssh_server_bare`: change user/group in `shell_out` command.
* Add FreeBSD support.
* Add ChefSpec tests for git-ssh-server::default recipe.
* Enable ChefSpec coverage.
* providers/bare: ignore FC023 rule.
* Gemfile:
 * Move test-kitchen gems to `:integration` group.
 * Fix *Illformed requirement in "berkshelf"*.
* Add travis.yml file.
* Test for the update-hook ([issue #2](https://github.com/zuazo/git-ssh-server-cookbook/pull/2), thanks [Arnold Krille](https://github.com/kampfschlaefer)).
* Update tests: add Gemfile, Berksfile and Rakefile templates.
* Update kitchen.yml file.
* Move *test/kitchen/cookbooks* to *test/cookbooks*.
* README:
 * Split in multiple files.
 * Add multiple badges.
 * Fixes and improvements.

## v0.2.0 (2014-01-18)

* Add update server hook ([issue #1](https://github.com/zuazo/git-ssh-server-cookbook/pull/1), thanks [Arnold Krille](https://github.com/kampfschlaefer)).

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
