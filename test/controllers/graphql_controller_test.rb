# typed: false
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
          extractedBody,
          url
        }
      }
    EOS

    post :execute, params: { query: query }
    json = JSON.parse(@response.body)
    assert_not json["errors"], json.to_s

    assert_equal Page::RECENT_PAGE_COUNT_SMT, json['data']['pages'].count

    page =  json['data']['pages'].first
    assert page['id']
    assert_equal 'latest_page', page['title']
    assert_equal 'latest_page body', page['body']
    assert_equal '<p>latest_page body</p>', page['extractedBody'].strip
    assert_equal '/latest_page', page['url']
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

  test 'should update page' do
    page = pages(:page_1)

    query = <<-EOS
      mutation {
        updatePage(input: {
          id: #{page.id},
          title: "new_title1",
          body: "new_body1"
        }) {
          id
        }
      }
    EOS

    post :execute, params: { query: query }
    json = JSON.parse(@response.body)

    assert_not json["errors"], json.to_s
    assert_equal page.id, json['data']['updatePage']['id'].to_i

    page.reload
    assert_equal 'new_title1', page.title
    assert_equal 'new_body1', page.body
  end
end
