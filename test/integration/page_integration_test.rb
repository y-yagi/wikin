require 'test_helper'

class PageIntegrationTest < ActionDispatch::IntegrationTest
  def setup
    page.driver.browser.authorize('basic_auth_name', 'basic_auth_password')
    visit root_path
  end

  test 'page include "TOP" when visit to root path' do
    assert_match 'TOP', page.text
  end

  test 'page include recent update page titles when visit to root path' do
    assert_match 'latest_page', page.text
  end

  test 'create new page'do
    before_count = Page.count
    click_link 'ページ作成'
    fill_in 'page_title', with: '新規ページタイトル'
    fill_in 'page_body', with: '新規ページ本文'
    click_button '登録する'

    assert_equal Page.count, before_count + 1

    visit Page.last.to_path
    assert_match '新規ページタイトル', page.text
    assert_match '新規ページ本文', page.text
  end

  test 'update page' do
    old_page = Page.find_by(title: 'child_title')

    visit old_page.to_path
    click_link '編集'
    fill_in 'page_body', with: 'child-body-update'
    click_button '更新する'

    old_page.reload
    visit old_page.to_path
    assert_match 'child-body-update', page.text
  end

  test 'search pages' do
    fill_in '_query', with: 'parents'
    click_button '検索'
    result_text = find(:css, '.search-result').text

    assert_match 'parents_title', result_text
    assert_match 'grandparents_title', result_text
  end
end
