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

    assert_text 'archive_paged_include_tags'
  end

  test 'show archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    assert_text 'archive_paged_include_tags'
  end

  test 'destroy archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    accept_alert { first("a[title='削除']").click }
    assert_text i18n_messages(:destroy_page)

    visit archived_page_path(archived_page)
    assert_text 'not found'
  end

  test 'restore archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    accept_alert { first("a[title='リストア']").click }
    assert_text i18n_messages(:restore_page)

    visit pages_path
    assert_text 'archive_paged_include_tags'

    click_link 'アーカイブページ一覧'
    assert_no_text 'archive_paged_include_tags'
  end
end

