# coding: us-ascii
# frozen_string_literal: true

source 'https://rubygems.org'

gemspec

group :development, :test do
  gem 'rake', '~> 13.0.6'
  gem 'irb', '~> 1.6.4'
  gem 'irb-power_assert', '0.1.1'
end

group :development do
  gem 'yard', '~> 0.9.34', require: false
  # https://github.com/rubocop/rubocop/pull/10796
  gem 'rubocop', '~> 1.54.0', require: false
  gem 'rubocop-rake', '~> 0.6.0', require: false
end

group :test do
  gem 'declare', '~> 0.4.0'
  gem 'warning', '~> 1.3.0'
end
