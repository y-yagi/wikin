ruby '2.2.2'

source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.2.3.rc1'
gem 'sass-rails', '~> 5.0.0'
gem 'uglifier', '>= 1.3.0'
gem 'coffee-rails', '~> 4.0.0'

gem 'jquery-rails'
gem 'turbolinks'
gem 'jbuilder', '~> 2.0'

gem 'spring',        group: :development
gem 'pg'

gem 'edge'
gem 'paranoia', '~> 2.0'
gem 'paranoia_uniqueness_validator'
gem 'rails-assets-bootstrap-theme-white-plum'

gem 'redcarpet'
gem 'dotenv-rails'
gem 'models-to-sql-rails', github: 'y-yagi/models-to-sql-rails'
gem 'active_decorator'
gem 'newrelic_rpm'

gem 'jquery-turbolinks'
gem 'http_accept_language'
gem 'rails-assets-font-awesome'

group :test, :development do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'annotate', github: 'ctran/annotate_models'
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
