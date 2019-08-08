require "test_helper"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :headless_chrome, screen_size: [1400, 1400]

  setup do
    Capybara.current_driver = :apparition
    page.driver.browser.url_whitelist = %w(127.0.0.1)
  end
end
