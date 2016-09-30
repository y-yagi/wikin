require 'test_helper'
require 'minitest/mock'

class PathConstraintTest< ActiveSupport::TestCase
  test 'invalid title' do
    request = Minitest::Mock.new
    request.expect(:path, 'search')

    assert_not PathConstraint.new.matches?(request)
  end
end
