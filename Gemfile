ruby '2.3.0'

source 'https://rubygems.org'

gem 'rails', '5.0.0.rc1'
gem 'sass-rails', '~> 6.x'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'

gem 'jquery-rails'
gem 'turbolinks', '~> 5.0.0.beta'
gem 'jbuilder', '~> 2.0'

gem 'spring',        group: :development
gem 'pg'

gem 'edge'

gem 'redcarpet'
gem 'dotenv-rails'
gem 'models-to-sql-rails', github: 'y-yagi/models-to-sql-rails'
gem 'active_decorator', github: 'y-yagi/active_decorator', branch: 'make_work_with_rails_5.0.0.beta3'

gem 'http_accept_language'

gem 'rake-guardian'

gem 'sprockets', '~> 4.x'

group :test, :development do
  gem 'byebug'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-minitest'

  gem 'minitest-sound', github: 'y-yagi/minitest-sound'
  gem 'minitest-slow_test'
  gem 'capybara'
  gem 'poltergeist'
  gem 'rails-footnotes'
  gem 'rack-mini-profiler', github: 'MiniProfiler/rack-mini-profiler'

  gem 'coveralls', require: false
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

gem 'nokogiri', '>= 1.6.8'
