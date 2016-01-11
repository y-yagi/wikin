ruby '2.3.0'

source 'https://rubygems.org'

gem 'rails', '5.0.0.beta1'
gem 'sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'spring',        group: :development
gem 'pg'

gem 'edge'

gem 'redcarpet'
gem 'dotenv-rails', github: 'y-yagi/dotenv', branch: 'rails_5_0'
gem 'models-to-sql-rails', github: 'y-yagi/models-to-sql-rails'
gem 'active_decorator'

gem 'jquery-turbolinks'
gem 'http_accept_language'

gem 'rake-guardian'

group :test, :development do
  gem 'byebug'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-minitest'

  gem 'minitest-sound', github: 'y-yagi/minitest-sound'
  gem 'minitest-slow_test'
  gem 'capybara', github: 'jnicklas/capybara'
  gem 'poltergeist'

  gem 'coveralls', require: false
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

gem 'nokogiri', '>= 1.6.7.2'
