# -*- encoding: utf-8 -*-
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kaleidoscope/version'

Gem::Specification.new do |gem|
  gem.name          = "kaleidoscope"
  gem.version       = Kaleidoscope::VERSION
  gem.platform      = Gem::Platform::RUBY
  gem.authors       = ["Josh Smith"]
  gem.email         = ["joshdotsmith@gmail.com"]
  gem.description   = %q{Color search for Rails}
  gem.summary       = %q{Kaleidoscope is color search for Rails using Active Record and Paperclip. The intent behind it was to index a database of images by color for quick retrieval.}
  gem.homepage      = "https://github.com/JoshSmith/kaleidoscope"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.requirements << "ImageMagick"
  gem.required_ruby_version = ">= 2.1.0"

  gem.add_dependency('rails', '>= 4.0.0')

  gem.add_dependency('activerecord', '>= 3.0.0')
  gem.add_dependency('activemodel', '>= 3.0.0')
  gem.add_dependency('activesupport', '>= 3.0.0')

  gem.add_dependency('rmagick', '>= 2.13.0')

  gem.add_dependency('paperclip', '>= 3.3.0')

  gem.add_dependency('delayed_job', '>= 3.0.0')

  gem.add_development_dependency('rspec')
  gem.add_development_dependency('generator_spec')
  gem.add_development_dependency('railties')
  gem.add_development_dependency('rails')
end
