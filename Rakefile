# frozen_string_literal: true

require 'rubygems'
require 'rake/extensiontask'

task default: :compile

begin
  require 'jeweler'
  Jeweler::Tasks.new do |gem|
    gem.name = 'tdes'
    gem.summary = 'triple DES encryption implemented in C'
    gem.description = 'triple DES encryption implemented in C using openssl'
    gem.email = 'gabriel.bastos@cloudwalk.io'
    gem.homepage = 'https://github.com/cloudwalk/ruby-3des'
    gem.authors = ['Gabriel Bastos']
    gem.files = FileList['lib/**/*.rb', 'ext/**/*']
    gem.files.exclude 'lib/tdes/*.so'
    gem.extensions = FileList['ext/**/extconf.rb']
    gem.license = 'MIT'
  end
  Jeweler::GemcutterTasks.new
rescue LoadError
  puts 'Jeweler (or a dependency) not available. Install it with: gem install jeweler'
end

Rake::ExtensionTask.new 'tdes' do |ext|
  ext.lib_dir = 'lib/tdes'
end
