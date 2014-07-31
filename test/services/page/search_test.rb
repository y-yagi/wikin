require 'test_helper'

class Page::SearchTest < ActiveSupport::TestCase
  test 'can acquire the data included in the title' do
    result = Page::Search.new('search_text_include_title').matches
    assert_equal 1, result.count
    assert_match /search_text_include_title/, result.first.title
  end

  test 'can acquire the data included in the body' do
    result = Page::Search.new('search_text_include_body').matches
    assert_equal 1, result.count
    assert_match /search_text_include_body/, result.first.body
  end

  test 'can acquire the data included in the body and title' do
    result = Page::Search.new('search_text').matches
    assert_equal 2, result.count
  end
end
