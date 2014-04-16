# -*- encoding: utf-8 -*-
require File.expand_path('../lib/simplemailr/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rob Bazinet"]
  gem.email         = ["rbazinet@simplemailr.com"]
  gem.description   = "A ruby client for the Simplemailr event API."
  gem.summary       = "A ruby client for the Simplemailr event API."
  gem.homepage      = "http://simplemailr.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "simplemailr"
  gem.require_paths = ["lib"]
  gem.version       = Simplemailr::VERSION

  gem.add_dependency('httparty', ["< 1.0", ">= 0.5"])

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('fakeweb')
end
