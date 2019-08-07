require "application_system_test_case"

class ArchivedPagesTest < ApplicationSystemTestCase
  setup do
    auth = ActionController::HttpAuthentication::Basic.encode_credentials(ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
    page.driver.add_headers("Authorization" => auth)

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

    accept_confirm { first("a[title='削除']").click }

    visit archived_page_path(archived_page)
    assert_text 'not found'
  end

  test 'restore archived page' do
    archived_page = archived_pages(:include_tags)
    visit archived_page_path(archived_page)

    accept_confirm { first("a[title='リストア']").click }

    visit pages_path
    assert_text 'archive_paged_include_tags'

    click_link 'アーカイブページ一覧'
    assert_no_text 'archive_paged_include_tags'
  end
end

