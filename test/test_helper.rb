require 'coveralls'
Coveralls.wear!('rails')

ENV['RAILS_ENV'] ||= 'test'
require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/slow_test'

Minitest::SlowTest.long_test_time = 0.5

ENV["BASIC_AUTH_USER"] = 'basic_auth_name'
ENV["BASIC_AUTH_PASSWORD"] = 'basic_auth_password'

class ActiveSupport::TestCase
  fixtures :all

  def assert_valid(record, message = nil)
    message ||= "Expected #{record.inspect} to be valid"
    assert record.valid?, message
  end

  def assert_invalid(record, options = {})
    assert record.invalid?, "Expected #{record.inspect} to be invalid"
    options.each do |attribute, message|
      assert_includes record.errors[attribute], message
    end
  end
end

class ActionDispatch::IntegrationTest
  fixtures :all
  include Capybara::DSL

  require 'capybara/poltergeist'
  Capybara.javascript_driver = :poltergeist
end

Minitest::Sound.success = '/home/yaginuma/Dropbox/tmp/music/other/sey.mp3'
Minitest::Sound.failure = '/home/yaginuma/Dropbox/tmp/music/other/mdai.mp3'
Minitest::Sound.during_test = '/home/yaginuma/tmp/during_test.mp3'
