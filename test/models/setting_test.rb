require 'test_helper'

class SettingTest < ActiveSupport::TestCase
  test "set one time password secret" do
    setting = Setting.new
    setting.enable_one_time_password = true
    setting.save!

    assert setting.reload.one_time_password_secret
  end

  test "restore secret" do
    setting = Setting.new
    setting.enable_one_time_password = true
    setting.save!

    assert_nothing_raised do
      setting.original_one_time_password_secret
    end
  end
end
