require 'test_helper'

class AdminControllerTest < ActionController::TestCase
  test "should get dump" do
    get :dump
    assert_response :success
  end

end
