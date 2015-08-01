ruby '2.2.2'

source 'https://rubygems.org'

gem 'rails', github: "rails/rails"
gem 'sprockets-rails', github: "rails/sprockets-rails"
gem 'arel', github: "rails/arel"
gem 'sass-rails', '~> 5.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'spring',        group: :development
gem 'pg'

gem 'edge'

gem 'redcarpet'
gem 'dotenv-rails', github: 'y-yagi/dotenv'
gem 'models-to-sql-rails', github: 'y-yagi/models-to-sql-rails'
gem 'active_decorator'

gem 'jquery-turbolinks'
gem 'http_accept_language'


group :test, :development do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'guard'
  gem 'guard-minitest'

  gem 'minitest-sound'
  gem 'minitest-slow_test'
  gem 'capybara'
  gem 'poltergeist'

  gem 'rails-footnotes', '>= 4.0.0', '<5'
  gem 'coveralls', require: false
end

group :production do
  gem 'unicorn'
  gem 'rails_12factor'
end

source 'https://rails-assets.org' do
  gem 'rails-assets-bootstrap-theme-white-plum'
  gem 'rails-assets-font-awesome'
end
