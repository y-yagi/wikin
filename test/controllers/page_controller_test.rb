# typed: false
require 'test_helper'

class PagesControllerTest < ActionController::TestCase
  def setup
    set_authorization
  end

  test 'should get index in json format' do
    get :index, format: :json
    assert_response :success
  end

  test 'should get index in json format with recent_pages params' do
    get :index, format: :json, params: { recent_pages: true }
    json = JSON.parse(@response.body)

    assert_equal Page::RECENT_PAGE_COUNT_SMT, json['results_returned']
    assert_equal 'latest_page', json['pages'].first['title']
    assert_equal %w(tag1 tag2), json['pages'].first['tags']
  end

  test 'should get search in json format' do
    get :search, format: :json
    assert_response :success
  end

  test 'should get search data which I appointed at query' do
    get :search, format: :json, params: { query: 'latest' }
    json = JSON.parse(@response.body)

    assert_equal 1, json['results_returned']
    assert_equal 'latest_page', json['pages'].first['title']
    assert_equal %w(tag1 tag2), json['pages'].first['tags']
  end

  test 'should get titles in json format' do
    get :titles, format: :json
    assert_response :success
  end

  test 'should get title data which I appointed at query' do
    get :titles, format: :json, params: { query: 'latest' }
    json = JSON.parse(@response.body)
    assert_equal 'latest_page', json['suggestions'].first['value']
  end

  test 'should create page with valid parameters' do
    post :create, params: { page: { title: 'new_title1', body: 'new_body1' } }, format: :json

    json = JSON.parse(@response.body)
    assert_equal 'ok', json['status']
    assert_equal 0, json['errors'].count
  end

  test 'should not create page with invalid parameters' do
    patch :create, params: { page: { title: '', body: 'new_body1' } }, format: :json
    json = JSON.parse(@response.body)

    assert_response :bad_request
    assert_equal 'bad_request', json['status']
    assert_equal 1, json['errors'].count
    assert_equal 'title', json['errors'].first.first
  end

  test 'should update page with valid parameters' do
    @page = pages(:page_1)
    patch :update, params: { id: @page.id, page: { title: 'new_title1', body: 'new_body1' } }, format: :json

    json = JSON.parse(@response.body)
    assert_equal 'ok', json['status']
    assert_equal 0, json['errors'].count

    @page.reload
    assert_equal 'new_title1', @page.title
    assert_equal 'new_body1', @page.body
  end

  test 'should not update page with invalid parameters' do
    @page = pages(:page_1)

    patch :update, params: { id: @page.id, page: { title: '', body: 'new_body1' } }, format: :json

    json = JSON.parse(@response.body)
    assert_equal 'unprocessable_entity', json['status']
    assert_equal 1, json['errors'].count
    assert_equal 'title', json['errors'].first.first
  end

  test 'should get preview' do
    get :preview, params: { page_body: %(**test**\n\n* 1\n* 2) }, format: :js, xhr: true
    expect = <<-'EOS'.strip_heredoc
      $("#preview_body").html("<p><strong>test<\/strong><\/p>\n\n<ul>\n<li>1<\/li>\n<li>2<\/li>\n<\/ul>\n");
      $('#page_body').hide()

      $('#preview_link').hide()
      $('#preview_body').show()
      $('#edit_link').show()
    EOS
    assert_equal expect, @response.body
  end
end
