# coding: utf-8
lib = File.expand_path('../lib', __FILE__)
$LOAD_PATH.unshift(lib) unless $LOAD_PATH.include?(lib)
require 'kolekti/version'

Gem::Specification.new do |spec|
  spec.name          = "kolekti"
  spec.version       = Kolekti::VERSION
  spec.authors       = ["Rafael Reggiani Manzo"]
  spec.email         = ["rr.manzo@gmail.com"]
  spec.license       = "LGPLv3"

  spec.summary       = %q{Provides basic API for KalibroProcessor Collector}
  spec.description   = %q{This gem defines how KalibroCollector expects his collectors to provide the parsed data so it can persist and process those results}
  spec.homepage      = "https://github.com/mezuro/kolekti"

  spec.files         = `git ls-files -z`.split("\x0").reject { |f| f.match(%r{^(test|spec|features)/}) }
  spec.bindir        = "exe"
  spec.executables   = spec.files.grep(%r{^exe/}) { |f| File.basename(f) }
  spec.require_paths = ["lib"]

  spec.add_dependency "kalibro_client", "~> 3.0"

  spec.add_development_dependency "bundler", "~> 1.10"
  spec.add_development_dependency "rake", "~> 10.0"
  spec.add_development_dependency "rspec"
  spec.add_development_dependency "cucumber", "~> 2.1.0"
  spec.add_development_dependency "mocha", "~> 1.1.0"
  spec.add_development_dependency "simplecov"
  spec.add_development_dependency "factory_girl", "~> 4.5.0"
  spec.add_development_dependency "codeclimate-test-reporter"
end
