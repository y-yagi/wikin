source 'https://rubygems.org'
source 'https://rails-assets.org'

gem 'rails', '4.2.0.beta1'
gem 'sass-rails', '~> 5.0.0.beta1'
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

group :test, :development do
  gem 'pry-rails'
  gem 'pry-doc'
  gem 'pry-stack_explorer'
  gem 'pry-byebug'
  gem 'tapp'

  gem 'better_errors'
  gem 'binding_of_caller'
  gem 'quiet_assets'
  gem 'annotate', github: 'ctran/annotate_models'
#  gem 'rack-mini-profiler'
  gem 'xray-rails'
  gem 'guard-minitest'

  gem 'minitest-sound'
  gem 'minitest-slow_test', github: 'y-yagi/minitest-slow_test'
  gem 'capybara'
  gem 'poltergeist'

  gem 'rails-footnotes', '>= 4.0.0', '<5'
  gem 'coveralls', require: false
end

group :production do
  gem 'rails_12factor'
end
