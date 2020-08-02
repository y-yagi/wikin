require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  def host!(_host)
    super
    auth = "#{ENV["BASIC_AUTH_USER"]}:#{ENV["BASIC_AUTH_PASSWORD"]}"
    Capybara.app_host = "http://#{auth}@127.0.0.1"
  end

  setup do
    visit root_path
  end

  test 'page include "TOP" when visit to root path' do
    assert_text '最近更新されたページ'
  end

  test 'page include recent update page titles when visit to root path' do
    assert_text 'latest_page'
  end

  test 'create new page' do
    before_count = Page.count
    click_link 'ページ作成'
    fill_in 'page_title', with: '新規ページタイトル'
    fill_in 'page_body', with: '新規ページ本文'
    fill_in 'page_tags', with: 'タグ'
    find_button i18n_button(:create)
    click_button i18n_button(:create)

    assert_equal Page.count, before_count + 1

    visit Page.last.to_path
    assert_text '新規ページタイトル'
    assert_text '新規ページ本文'
    assert_text 'タグ'
  end

  test 'display error message when going to make it with unjust data' do
    click_link 'ページ作成'
    fill_in 'page_title', with: ''
    fill_in 'page_body', with: '新規ページ本文'
    find_button i18n_button(:create)
    click_button i18n_button(:create)

    assert_not_empty page.find("#page_title").native.attribute('validationMessage')
  end

  test 'update page' do
    old_page = pages(:child)

    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: 'child-body-update'
    find_button i18n_button(:update)
    click_button i18n_button(:update)

    old_page.reload
    visit old_page.to_path
    assert_text 'child-body-update'
  end

  test 'undo update' do
    old_page = pages(:child)
    title = old_page.title
    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: 'child-body-update'
    find_button i18n_button(:update)
    click_button i18n_button(:update)
    click_link i18n_messages(:undo_page_link)
    visit old_page.to_path

    assert_no_match 'child-body-update', page.text
    assert_text title
  end


  test 'display error message when going to update it with unjust data' do
    old_page = pages(:child)
    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: ''
    find_button i18n_button(:update)
    click_button i18n_button(:update)

    assert_not_empty page.find("#page_body").native.attribute('validationMessage')
  end

  test 'search pages' do
    fill_in 'query', with: 'parents'
    click_button '検索'
    result_text = find(:css, '.search-result').text

    assert_text 'parents_title'
    assert_text 'grandparents_title'
  end

  test 'destroy page' do
    page_data = pages(:child)
    visit page_data.to_path

    accept_alert { first("a[title='削除']").click }
    assert_text i18n_messages(:destroy_page)

    visit page_data.to_path
    assert_text 'not found'
  end

  test 'cannot destroy page when page has child page' do
    page_data = pages(:grandparents)
    visit page_data.to_path
    accept_alert { first("a[title='削除']").click }

    assert_text i18n_messages(:have_child_page)
  end

  test 'restore page' do
    page_data = pages(:child)
    visit page_data.to_path
    accept_alert { first("a[title='削除']").click }
    assert_text i18n_messages(:destroy_page)

    click_link i18n_messages(:restore_page_link)
    visit page_data.to_path
    assert_text 'child_title'
  end

  test 'page index' do
    visit pages_path

    assert_text 'search_text_include_title'
    assert_text 'grandparents_title / parents_title / child_title'
  end

  test 'page index with tag parameter' do
    visit pages_path(tag: 'tag1')

    assert_text 'tags_page_title'
    assert_no_match 'search_text_include_title', page.text
  end

  test 'archive page' do
    page_data = pages(:child)
    visit page_data.to_path

    accept_alert { first("a[title='アーカイブ']").click }
    assert_text i18n_messages(:archive_page)
  end
end
