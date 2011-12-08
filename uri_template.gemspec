# -*- encoding: utf-8 -*-
require File.expand_path('../lib/uri_template/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Paul Sadauskas"]
  gem.email         = ["psadauskas@gmail.com"]
  gem.description   = %q{TODO: Write a gem description}
  gem.summary       = %q{TODO: Write a gem summary}
  gem.homepage      = ""

  gem.executables   = `git ls-files -- bin/*`.split("\n").map{ |f| File.basename(f) }
  gem.files         = `git ls-files`.split("\n")
  gem.test_files    = `git ls-files -- {test,spec,features}/*`.split("\n")
  gem.name          = "uri_template"
  gem.require_paths = ["lib"]
  gem.version       = UriTemplate::VERSION

  gem.add_dependency "parslet"
  gem.add_dependency "addressable"

  gem.add_development_dependency "rspec"
end
