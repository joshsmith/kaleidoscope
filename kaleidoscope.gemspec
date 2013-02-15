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
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = "https://github.com/JoshSmith/kaleidoscope"

  gem.files         = `git ls-files`.split($/)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.require_paths = ["lib"]

  gem.requirements << "ImageMagick"
  gem.required_ruby_version = ">= 1.9.2"

  gem.add_dependency('activerecord', '>= 3.0.0')
  gem.add_dependency('activemodel', '>= 3.0.0')
  gem.add_dependency('activesupport', '>= 3.0.0')

  gem.add_dependency "RMagick", ["= 2.13.2"]
  gem
end
