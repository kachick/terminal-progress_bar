require File.expand_path('../lib/terminal/progressbar/version', __FILE__)

Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.summary       = %q{100% |***********************************************************************|}
  gem.description   = %q{100% |***********************************************************************|}
  gem.homepage      = 'https://github.com/kachick/terminal-progress_bar'

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.name          = 'terminal-progress_bar'
  gem.require_paths = ['lib']
  gem.version       = Terminal::ProgressBar::VERSION.dup

  gem.required_ruby_version = '>= 1.9.2'

  gem.add_runtime_dependency 'optionalargument', '~> 0.0.3'

  gem.add_development_dependency 'declare', '~> 0.0.5'
  gem.add_development_dependency 'yard', '~> 0.8'
end

