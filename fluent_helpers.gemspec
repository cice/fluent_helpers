# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'fluent_helpers/version'

Gem::Specification.new do |spec|
  spec.name          = "fluent_helpers"
  spec.version       = FluentHelpers::VERSION
  spec.authors       = ["Marian Theisen"]
  spec.email         = ["marian@cice-online.net"]
  spec.summary       = %q{FluentHelpers are great}
  spec.description   = %q{No. Really great!}
  spec.homepage      = ""
  spec.license       = "MIT"

  spec.files         = `git ls-files -z`.split("\x0")
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_dependency 'activesupport', '>= 4.0'
  spec.add_dependency 'actionpack', '>= 4.0'

  spec.add_development_dependency "bundler"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec", "~> 3.2"
  spec.add_development_dependency "rspec-rails", "~> 3.2"
  spec.add_development_dependency "rspec-html-matchers"
  spec.add_development_dependency "byebug"
  spec.add_development_dependency 'simplecov'
end
