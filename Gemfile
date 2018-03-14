ruby '2.4.1'

source 'https://rubygems.org'

gem 'rails', '5.2.0.rc1'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'jb'
gem 'pg', '< 1.0.0'
gem 'edge'
gem 'redcarpet'
gem 'dotenv-rails'
gem 'models-to-sql-rails', github: 'y-yagi/models-to-sql-rails'
gem 'active_decorator'
gem 'http_accept_language'
gem 'rake-guardian'
gem 'sprockets', '~> 4.x'
gem 'rouge'
gem 'nokogiri', '>= 1.8.1'
gem 'graphql'
gem 'puma'

group :development do
  gem 'spring'
  gem 'graphiql-rails'
end

group :test, :development do
  gem 'minitest', '~> 5.11.3'
  gem 'byebug'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-minitest'

  gem 'minitest-sound'
  gem 'minitest-slow_test'
  gem 'minitest-sub_test_case'
  gem 'capybara'
  gem 'chromedriver-helper'
  gem 'selenium-webdriver'
  gem 'rack-mini-profiler'

  gem 'coveralls', require: false
end

group :production do
  gem 'skylight'
  gem 'rails_12factor'
end
