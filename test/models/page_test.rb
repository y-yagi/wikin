require 'test_helper'

class PageTest < ActiveSupport::TestCase
  test 'recently updated pages group by date' do
    pages = Page.recently_updated
    assert_equal 2, pages.count
    assert_equal (Date.today + 2), pages.first[0]
    assert_equal (Date.today), pages.second[0]
  end

  test 'find page when use valid title' do
    assert_instance_of Page, Page.find_by_titles(%w(grandparents_title parents_title child_title))
    assert_equal pages(:child), Page.find_by_titles(%w(grandparents_title parents_title child_title))
  end

  test 'do not find page when use invalid title' do
    assert_nil Page.find_by_titles(%w(not_exist))
  end

  test 'create url by title' do
    page = pages(:grandparents)
    assert_equal '/' + page.title, page.to_path
  end

  test 'url include parent title' do
    page = pages(:child)

    assert_match page.parent.title, page.to_path
    assert_match page.parent.title, page.to_path
  end

  test 'validate error when set invalid title' do
    page = Page.new(title: 'admin', body: 'test')

    assert_invalid page,
      title: 'を使用出来ません。他の値を使用してください。'
  end

  test 'validate error when set invalid parent name' do
    page = Page.new(title: 'test', body: 'test', parent_name: 'not_exist')

    assert_invalid page,
      parent_name: 'は存在しません。タイトルを確認してください。'
  end

  test 'can not create same title when parent is same' do
    page = Page.new(title: 'child_title', body: 'body', parent: pages(:parents))

    assert_invalid page, title: 'はすでに存在します。'
  end

  test 'can create same title when parent is different' do
    page = Page.new(title: 'child_title', body: 'body', parent: pages(:latest_page))

    assert_valid page
  end

  test '`can_destory?` return false when page has child page' do
    page = pages(:grandparents)
    assert_equal false, page.can_destory?
  end

  test '`can_destory?` return true when page dosent have child page' do
    page = pages(:child)
    assert_equal true, page.can_destory?
  end
end
