# -*- encoding: utf-8 -*-
require File.expand_path('../lib/admin-theme/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ["Nihad Abbasov"]
  gem.email         = ["mail@narkoz.me"]
  gem.description   = %q{Generate admin panels without pain}
  gem.summary       = %q{Admin panel generator}
  gem.homepage      = "https://github.com/simmetria/admin-theme"

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = "admin-theme"
  gem.require_paths = ["lib"]
  gem.version       = Admin::Theme::VERSION

  gem.add_runtime_dependency 'rails', '~> 3.1'
  gem.add_runtime_dependency 'thor',  '~> 0.14'

  gem.add_development_dependency 'spinach'
end
