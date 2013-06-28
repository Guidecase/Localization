# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'localization/version'

Gem::Specification.new do |spec|
  spec.name          = "localization"
  spec.version       = Localization::VERSION
  spec.summary       = "Earlydoc localization"
  spec.description   = "This gem provides localization help to Rails controllers and views"
  spec.authors       = ['Earlydoc', 'Travis Dunn']
  spec.email         = 'developer@earlydoc.com'
  spec.homepage      = 'https://www.earlydoc.com'
  spec.license       = "MIT"
  spec.files         = `git ls-files`.split($/)
  spec.executables   = spec.files.grep(%r{^bin/}) { |f| File.basename(f) }
  spec.test_files    = spec.files.grep(%r{^(test|spec|features)/})
  spec.require_paths = ["lib"]

  spec.add_development_dependency "bundler", "~> 1.3"
  spec.add_development_dependency "rake"

  spec.add_dependency 'activesupport', '~> 4.0.0'
end