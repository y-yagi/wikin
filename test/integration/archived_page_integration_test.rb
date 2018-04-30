require 'test_helper'

class ArchivedPageIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    page.driver.browser.authorize(ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
    visit root_path
  end

  test 'archived pages' do
    click_link 'アーカイブページ一覧'

    assert_match 'archive_paged_include_tags', page.text
  end

  test 'show archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    assert_match 'archive_paged_include_tags', page.text
  end

  test 'destroy archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    first("a[title='削除']").click

    visit archived_page_path(archived_page)
    assert_equal 404, page.status_code
  end

  test 'restore archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    first("a[title='リストア']").click

    visit pages_path
    assert_match 'archive_paged_include_tags', page.text

    click_link 'アーカイブページ一覧'
    assert_no_match 'archive_paged_include_tags', page.text
  end
end
