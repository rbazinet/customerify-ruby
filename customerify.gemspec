# -*- encoding: utf-8 -*-
require File.expand_path('../lib/customerify/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Rob Bazinet"]
  gem.email         = ["rbazinet@customerify.com"]
  gem.description   = "A ruby client for the Customerify event API."
  gem.summary       = "A ruby client for the Customerify event API."
  gem.homepage      = "http://customerify.com"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "customerify"
  gem.require_paths = ["lib"]
  gem.version       = Customerify::VERSION

  gem.add_dependency('httparty', ["< 1.0", ">= 0.5"])

  gem.add_development_dependency('rake')
  gem.add_development_dependency('rspec')
  gem.add_development_dependency('fakeweb')
end
