lib_name = 'terminal-progress_bar'.freeze

require_relative 'lib/terminal/progressbar/version'

Gem::Specification.new do |gem|
  gem.authors       = ['Kenichi Kamiya']
  gem.email         = ['kachick1+ruby@gmail.com']
  gem.summary       = %q{100% |***********************************************************************|}
  gem.description   = %q{100% |***********************************************************************|}

  gem.files         = `git ls-files`.split($\)
  gem.executables   = gem.files.grep(%r{^bin/}).map{ |f| File.basename(f) }
  gem.test_files    = gem.files.grep(%r{^(test|spec|features)/})
  gem.homepage      = "https://github.com/kachick/#{lib_name}"
  gem.license       = 'MIT'
  gem.name          = lib_name.dup
  gem.require_paths = ['lib']
  gem.version       = Terminal::ProgressBar::VERSION.dup

  gem.add_runtime_dependency 'optionalargument', '~> 0.1'

  gem.add_development_dependency 'declare', '~> 0.0.6'
  gem.add_development_dependency 'yard', '>= 0.8.7.6', '< 0.9'
  gem.add_development_dependency 'rake', '>= 10', '< 20'
  gem.add_development_dependency 'bundler', '>= 1.10', '< 2'

  if RUBY_ENGINE == 'rbx'
    gem.add_dependency 'rubysl', '~> 2.1'
  end
end
