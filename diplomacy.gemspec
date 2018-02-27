
# frozen_string_literal: true

lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'diplomacy/version'

Gem::Specification.new do |spec|
  spec.name          = 'diplomacy'
  spec.version       = Diplomacy::VERSION
  spec.authors       = ['Jordan Ryan Reuter']
  spec.email         = ['oss@jreut.com']

  spec.summary       = 'Utilities for the Diplomacy board game.'
  spec.homepage      = 'https://github.com/jreut/diplomacy'
  spec.license       = 'MIT'

  spec.files         = `git ls-files -z`.split("\x0").reject do |f|
    f.match(%r{^(test|spec|features)/})
  end
  spec.bindir        = 'exe'
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ['lib']

  spec.add_dependency 'anima', '~> 0.3'
  spec.add_dependency 'dry-monads', '~> 0.4'

  spec.add_development_dependency 'bundler', '~> 1.16'
  spec.add_development_dependency 'minitest', '~> 5.0'
  spec.add_development_dependency 'pry'
  spec.add_development_dependency 'rake', '~> 10.0'
  spec.add_development_dependency 'rubocop', '~> 0.52'
end
