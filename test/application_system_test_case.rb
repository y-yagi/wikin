require "test_helper"
require "test_recorder/rails"

class ApplicationSystemTestCase < ActionDispatch::SystemTestCase
  driven_by :selenium, using: :chrome, screen_size: [1400, 1400]

  setup do
    I18n.locale = :en if ENV['CI']
  end
end
