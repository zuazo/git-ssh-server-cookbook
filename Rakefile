# encoding: UTF-8
# -*- mode: ruby -*-
# vi: set ft=ruby :
# Based on magic_shell cookbook code, thanks @sethvargo.

# More info at https://github.com/jimweirich/rake/blob/master/doc/rakefile.rdoc

require 'bundler/setup'

namespace :style do
  require 'rubocop/rake_task'
  desc 'Run Ruby style checks using rubocop'
  RuboCop::RakeTask.new(:ruby)

  require 'foodcritic'
  desc 'Run Chef style checks'
  FoodCritic::Rake::LintTask.new(:chef)
end

desc 'Run all style checks'
task style: %w(style:chef style:ruby)

desc 'Run ChefSpec unit tests'
task :unit do
  require 'rspec/core/rake_task'
  RSpec::Core::RakeTask.new(:unit) do |t|
    t.rspec_opts = '--color --format progress'
    t.pattern = 'test/unit/**{,/*/**}/*_spec.rb'
  end
end

desc 'Run Test Kitchen integration tests'
task :integration do
  require 'kitchen'
  Kitchen.logger = Kitchen.default_file_logger
  Kitchen::Config.new.instances.each do |instance|
    instance.test(:always)
  end
end

namespace :travis do
  desc 'Run tests on Travis'
  task ci: %w(style unit)
end

task default: %w(style unit integration)
