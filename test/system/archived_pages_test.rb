require "application_system_test_case"

class ArchivedPagesTest < ApplicationSystemTestCase
  def host!(_host)
    super
    auth = "#{ENV["BASIC_AUTH_USER"]}:#{ENV["BASIC_AUTH_PASSWORD"]}"
    Capybara.app_host = "http://#{auth}@127.0.0.1"
  end

  setup do
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

    accept_alert { first("a[title='削除']").click }

    visit archived_page_path(archived_page)
    assert_match 'not found', page.text
  end

  test 'restore archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    accept_alert { first("a[title='リストア']").click }

    visit pages_path
    assert_match 'archive_paged_include_tags', page.text

    click_link 'アーカイブページ一覧'
    assert_no_match 'archive_paged_include_tags', page.text
  end
end

