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
    assert_equal Page.find_by(title: 'child_title'), Page.find_by_titles(%w(grandparents_title parents_title child_title))
  end

  test 'do not find page when use invalid title' do
    assert_nil Page.find_by_titles(%w(not_exist))
  end

  test 'create url by title' do
    page = Page.find_by(title: 'grandparents_title')

    assert_equal '/' + page.title, page.to_path
  end

  test 'url include parent title' do
    page = Page.find_by(title: 'child_title')

    assert_match page.parent.title, page.to_path
    assert_match page.parent.title, page.to_path
  end

  test 'validate error when set invalid title' do
    page = Page.new(title: 'admin', body: 'test')

    assert_not page.valid?
    assert_not_nil page.errors.get(:title)
  end

  test 'validate error when set invalid parent name' do
    page = Page.new(title: 'test', body: 'test', parent_name: 'not_exist')

    assert_not page.valid?
    assert_not_nil page.errors.get(:parent_name)
  end

  test 'can not create same title when parent is same' do
    page = Page.new(title: 'child_title', body: 'body', parent: Page.find_by(title: 'parents_title'))

    assert_not page.valid?
    assert_not_nil page.errors.get(:title)
  end

  test 'can create same title when parent is different' do
    page = Page.new(title: 'child_title', body: 'body', parent: Page.find_by(title: 'latest_page'))

    assert page.valid?
  end
end
