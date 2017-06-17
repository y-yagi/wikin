require 'test_helper'

class GraphqlControllerTest < ActionController::TestCase
  setup do
    set_authorization
  end

  test 'should get pages' do
    query = <<-EOS
      query {
        pages {
          id,
          title,
          body,
          extracted_body
        }
      }
    EOS

    post :execute, params: { query: query }
    json = JSON.parse(@response.body)
    assert_equal Page::RECENT_PAGE_COUNT_SMT, json['data']['pages'].count

    page =  json['data']['pages'].first
    assert page['id']
    assert_equal 'latest_page', page['title']
    assert_equal 'latest_page body', page['body']
    assert_equal '<p>latest_page body</p>', page['extracted_body'].strip
  end

  test 'should get page' do
    page = Page.first

    query = <<-EOS
      query {
        page(id: #{page.id}) {
          id,
          title,
          body,
        }
      }
    EOS

    post :execute, params: { query: query }
    json = JSON.parse(@response.body)
    p json
    assert json['data']['page']

    response_page = json['data']['page']
    assert_equal page.id, response_page['id'].to_i
    assert_equal page.title, response_page['title']
    assert_equal page.body, response_page['body']
  end

  test 'should search pages' do
    query = <<-EOS
      query {
        search(query: "latest") {
          id,
          title,
          body
        }
      }
    EOS

    post :execute, params: { query: query }
    json = JSON.parse(@response.body)

    assert_equal 1, json['data']['search'].count

    page =  json['data']['search'].first
    assert page['id']
    assert_equal 'latest_page', page['title']
    assert_equal 'latest_page body', page['body']
  end
end
