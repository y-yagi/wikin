require 'test_helper'
class AdminControllerTest < ActionController::TestCase
  def setup
    set_authorization
  end

  test 'should get dump' do
    get :dump
    assert_response :success
  end

  test 'dump data include "SETVAL" query' do
    get :dump
    id = Page.last.id
    assert_match "SELECT SETVAL('pages_id_seq', #{id});", @response.body
  end
end
