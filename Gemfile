source 'https://rubygems.org'

gem 'chef', '~> 11.16.4'
gem 'rake'
gem 'json', '~> 1.8.1'
gem 'chef-sugar'
gem 'knife-solo'

group :workflow do
  gem 'berkshelf', '~> 3.1.5'
  gem 'eventmachine', '1.0.3'
  gem 'unf'
end

group :development do
  gem 'guard'
  gem 'pry'
end

group :ci do
  gem 'chefspec', '~> 4.0'
  gem 'foodcritic', '~> 4.0'
  gem 'rubocop', '~> 0.26'
  gem 'rubocop-checkstyle_formatter', require: false
  gem 'coveralls'
  gem 'tailor'
end
