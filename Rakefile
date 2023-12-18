# frozen_string_literal: true

# source: https://stephenagrice.medium.com/making-a-command-line-ruby-gem-write-build-and-push-aec24c6c49eb

GEM_NAME = 'fli_video'

require 'bundler/gem_tasks'
require 'rspec/core/rake_task'
require 'fli_video/version'

RSpec::Core::RakeTask.new(:spec)

require 'rake/extensiontask'

desc 'Compile all the extensions'
task build: :compile

Rake::ExtensionTask.new('fli_video') do |ext|
  ext.lib_dir = 'lib/fli_video'
end

desc 'Publish the gem to RubyGems.org'
task :publish do
  version = FliVideo::VERSION
  system 'gem build'
  system "gem push #{GEM_NAME}-#{version}.gem"
end

desc 'Remove old *.gem files'
task :clean do
  system 'rm *.gem'
end

task default: %i[clobber compile spec]
