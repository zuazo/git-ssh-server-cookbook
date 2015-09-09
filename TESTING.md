Testing
=======

## Required Gems

* `vagrant`
* `foodcritic`
* `berkshelf`
* `chefspec`
* `test-kitchen`
* `kitchen-vagrant`

## Installing the Requirements

You must have [VirtualBox](https://www.virtualbox.org/) and [Vagrant](http://www.vagrantup.com/) installed.

You can install gem dependencies with bundler:

    $ gem install bundler
    $ bundle install --without travis

## Running the Syntax Style Tests

    $ bundle exec rake style

## Running the Unit Tests

    $ bundle exec rake unit

## Running the Integration Tests

    $ bundle exec rake integration

Or:

    $ bundle exec kitchen list
    $ bundle exec kitchen test
    [...]

## Using Vagrant with the Vagrantfile

### Vagrantfile Requirements

* ChefDK: https://downloads.chef.io/chef-dk/
* Berkhelf and Omnibus vagrant plugins:
```
$ vagrant plugin install vagrant-berkshelf vagrant-omnibus
```
* The path correctly set for ChefDK:
```
$ export PATH="/opt/chefdk/bin:${PATH}"
```

### Vagrantfile Usage

    $ vagrant up

To run Chef again on the same machine:

    $ vagrant provision

To destroy the machine:

    $ vagrant destroy
