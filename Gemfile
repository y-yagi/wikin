ruby '2.4.0'

source 'https://rubygems.org'

gem 'rails', '5.1.0.rc1'
gem 'sass-rails', github: 'rails/sass-rails'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails'
gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder'
gem 'jb'
gem 'spring',        group: :development
gem 'pg'
gem 'edge'
gem 'redcarpet'
gem 'dotenv-rails'
gem 'models-to-sql-rails', github: 'y-yagi/models-to-sql-rails'
gem 'active_decorator'
gem 'http_accept_language'
gem 'rake-guardian'
gem 'sprockets', '~> 4.x'
gem 'rouge'
gem 'nokogiri', '>= 1.6.8'

group :test, :development do
  gem 'byebug'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'guard'
  gem 'guard-minitest'

  gem 'minitest-sound'
  gem 'minitest-slow_test'
  gem 'minitest-sub_test_case'
  gem 'capybara'
  gem 'poltergeist'
  gem 'rails-footnotes'
  gem 'rack-mini-profiler'

  gem 'coveralls', require: false

  # TODO: remove update after Rails 5.1.0.beta2
  # REf: https://github.com/rails/rails/pull/28160
  gem 'puma'
end

group :production do
  gem 'skylight'
  gem 'unicorn'
  gem 'rails_12factor'
end
