# typed: false
ENV['RAILS_ENV'] ||= 'test'

def Warning.warn(str)
  return if str.match?("gems/graphql")
  super
end

require File.expand_path('../../config/environment', __FILE__)
require 'rails/test_help'
require 'capybara/rails'
require 'minitest/slow_test'

Minitest::SlowTest.long_test_time = 0.5

ENV["BASIC_AUTH_USER"] = 'basic_auth_name'
ENV["BASIC_AUTH_PASSWORD"] = 'basic_auth_password'

class ActiveSupport::TestCase
  parallelize
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

  def set_authorization
    @request.env['HTTP_AUTHORIZATION'] =
      ActionController::HttpAuthentication::Basic.encode_credentials(
        ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
  end
end

class ActionDispatch::IntegrationTest
  fixtures :all
  include Capybara::DSL

  Capybara.javascript_driver = :selenium_chrome_headless
end

if !ENV["DISABLE_MINITEST_SOUND"]
  Minitest::Sound.success = '/home/yaginuma/Dropbox/tmp/music/other/sey.mp3'
  Minitest::Sound.failure = '/home/yaginuma/Dropbox/tmp/music/other/mdai.mp3'
  Minitest::Sound.during_test = '/home/yaginuma/Dropbox/tmp/music/other/rs1_25_beatthemup.mp3'
end

