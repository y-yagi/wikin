require 'test_helper'

class PageIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    page.driver.browser.authorize(ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
    visit root_path
  end

  test 'page include "TOP" when visit to root path' do
    assert_match 'TOP', page.text
  end

  test 'page include recent update page titles when visit to root path' do
    assert_match 'latest_page', page.text
  end

  test 'create new page' do
    before_count = Page.count
    click_link 'ページ作成'
    fill_in 'page_title', with: '新規ページタイトル'
    fill_in 'page_body', with: '新規ページ本文'
    fill_in 'page_tags', with: 'タグ'
    click_button '登録する'

    assert_equal Page.count, before_count + 1

    visit Page.last.to_path
    assert_match '新規ページタイトル', page.text
    assert_match '新規ページ本文', page.text
    assert_match 'タグ', page.text
  end

  test 'display error message when going to make it with unjust data' do
    click_link 'ページ作成'
    fill_in 'page_title', with: ''
    fill_in 'page_body', with: '新規ページ本文'
    click_button '登録する'

    assert_match 'error', page.text
  end

  test 'update page' do
    old_page = pages(:child)

    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: 'child-body-update'
    click_button '更新する'

    old_page.reload
    visit old_page.to_path
    assert_match 'child-body-update', page.text
  end

  test 'undo update' do
    old_page = pages(:child)
    title = old_page.title
    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: 'child-body-update'
    click_button '更新する'
    click_link '更新の取り消し'
    visit old_page.to_path

    assert_no_match 'child-body-update', page.text
    assert_match title, page.text
  end


  test 'display error message when going to update it with unjust data' do
    old_page = pages(:child)
    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: ''
    click_button '更新する'

    assert_match 'error', page.text
  end

  test 'search pages' do
    fill_in '_query', with: 'parents'
    click_button '検索'
    result_text = find(:css, '.search-result').text

    assert_match 'parents_title', result_text
    assert_match 'grandparents_title', result_text
  end

  test 'destroy page' do
    page_data = pages(:child)
    visit page_data.to_path
    assert_equal 200, page.status_code

    first("a[title='削除']").click

    visit page_data.to_path
    assert_equal 404, page.status_code
  end

  test 'cannot destroy page when page has child page' do
    page_data = pages(:grandparents)
    visit page_data.to_path
    first("a[title='削除']").click

    assert_equal 200, page.status_code
    assert_match 'ページの削除は出来ません', page.text
  end

  test 'restore page' do
    page_data = pages(:child)
    visit page_data.to_path
    assert_equal 200, page.status_code
    first("a[title='削除']").click

    click_link '削除の取り消し'
    visit page_data.to_path
    assert_equal 200, page.status_code
    assert_match 'child_title', page.text
  end

  test 'invalid basic auth' do
    page.driver.browser.authorize('invalid_name', 'invalid_password')
    visit root_path
    assert_equal 401, page.status_code
  end

  test 'page index' do
    visit pages_path

    assert_match 'search_text_include_title', page.text
    assert_match 'grandparents_title / parents_title / child_title', page.text
  end
end
