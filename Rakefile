# frozen_string_literal: true

require 'bundler'
require 'bundler/gem_helper'
require_relative 'lib/tdes/version' unless defined? Tdes::VERSION
require 'rake/extensiontask'
require 'rake/testtask'

Bundler::GemHelper.install_tasks
gem_spec = Bundler.load_gemspec('tdes.gemspec')

Rake::ExtensionTask.new do |ext|
  ext.name = 'tdes'
  ext.gem_spec = gem_spec
  ext.ext_dir = 'ext/tdes'
  ext.source_pattern = "*.{c,h}"
  ext.lib_dir = 'lib/tdes'
end

Rake::TestTask.new do |t|
  t.libs << 'test'
end

task release: :build do
  system "gem push pkg/tdes-#{Tdes::VERSION}.gem"
end

desc 'Check if the compiled shared library exists'
task :check_compile do
  ruby_version = RbConfig::CONFIG['ruby_version']
  arch_dir = RbConfig::CONFIG['arch']
  lib_file = File.join('tmp', arch_dir, 'tdes', ruby_version, 'tdes.so')

  unless File.exist?(lib_file)
    Rake::Task[:compile].invoke
  end
end

task test: :check_compile

task default: :test
