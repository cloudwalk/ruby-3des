# frozen_string_literal: true

require_relative 'lib/tdes/version' unless defined? Tdes::VERSION

Tdes::GEMSPEC = Gem::Specification.new do |s|
  s.name = 'tdes'
  s.version = Tdes::VERSION
  s.authors = ['Gabriel Bastos']
  s.email = 'gabriel.bastos@cloudwalk.io'

  s.summary = 'triple DES encryption implemented in C'
  s.description = <<~DESCRIPTION
    triple DES encryption implemented in C using openssl
  DESCRIPTION
  s.homepage = 'https://github.com/cloudwalk/ruby-3des'
  s.licenses = %w[MIT]
  s.required_ruby_version = '>= 2.7'

  s.metadata['rubygems_mfa_required'] = 'true'

  s.files = [
    'ext/tdes/extconf.rb',
    'ext/tdes/tdes.c',
    'ext/tdes/tdes_class.c',
    'ext/tdes/tdes_class.h',
    'lib/tdes.rb',
    'lib/tdes/version.rb'
  ]
  s.extensions = %w[ext/tdes/extconf.rb]
  s.require_paths = %w[lib]
  s.rdoc_options  = ['--main', 'readme.md']
  s.extra_rdoc_files = ['LICENSE']

  # Adds a runtime dependency named gem with requirements to tdes gem
  # s.add_dependency 'example', '>= 0'

  # Development dependencies aren’t installed by default and aren’t activated when a gem is required.
  s.add_development_dependency 'minitest', '~> 5'
  s.add_development_dependency 'rake-compiler', '~> 1'
end
