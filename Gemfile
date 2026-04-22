source 'https://rubygems.org'

gemspec

group :development do
  gem 'rake'
  gem 'rubocop', '~>1.86'
end

group :test do
  gem 'bigdecimal'
  gem 'minitest', '~>4.0' if RUBY_VERSION.to_f > 2.1
  gem 'test-unit', '~>3.0' if RUBY_VERSION.to_f > 2.1
  gem 'rake'
end
