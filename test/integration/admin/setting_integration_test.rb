require 'test_helper'

class Admin::SettingIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    page.driver.browser.authorize(ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
    visit edit_admin_setting_path
  end


  test 'update one time password setting' do
    assert_not Setting.first.enable_one_time_password?
    check 'setting_enable_one_time_password'
    click_button '更新する'

    assert Setting.first.enable_one_time_password?
  end
end
