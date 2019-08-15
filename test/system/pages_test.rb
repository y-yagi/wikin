require "application_system_test_case"

class PagesTest < ApplicationSystemTestCase
  setup do
    auth = ActionController::HttpAuthentication::Basic.encode_credentials(ENV["BASIC_AUTH_USER"], ENV["BASIC_AUTH_PASSWORD"])
    page.driver.add_headers("Authorization" => auth)

    visit root_path
  end

  test 'page include "TOP" when visit to root path' do
    assert_text "TOP"
  end

  test 'page include recent update page titles when visit to root path' do
    assert_text "latest_page"
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
    assert_text "新規ページタイトル"
    assert_text "新規ページ本文"
    assert_text "タグ"
  end

  test 'display error message when going to make it with unjust data' do
    click_link 'ページ作成'
    fill_in 'page_title', with: ''
    fill_in 'page_body', with: '新規ページ本文'
    click_button '登録する'

    assert_not_empty page.find("#page_title").native.property('validationMessage')
  end

  test 'update page' do
    old_page = pages(:child)

    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: 'child-body-update'
    click_button '更新する'

    old_page.reload
    visit old_page.to_path
    assert_text "child-body-update"
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

    assert_no_text "child-body-update"
    assert_text "title"
  end


  test 'display error message when going to update it with unjust data' do
    old_page = pages(:child)
    visit old_page.to_path
    first("a[title='編集']").click
    fill_in 'page_body', with: ''
    click_button '更新する'

    assert_not_empty page.find("#page_body").native.property('validationMessage')
  end

  test 'search pages' do
    fill_in 'query', with: 'parents'
    click_button '検索'
    result_text = find(:css, '.search-result').text

    assert_text "parents_title"
    assert_text "grandparents_title"
  end

  test 'destroy page' do
    page_data = pages(:child)
    visit page_data.to_path

    accept_confirm { first("a[title='削除']").click }

    visit page_data.to_path
    assert_text "not found"
  end

  test 'cannot destroy page when page has child page' do
    page_data = pages(:grandparents)
    visit page_data.to_path
    accept_confirm { first("a[title='削除']").click }

    assert_text "ページの削除は出来ません"
  end

  test 'restore page' do
    page_data = pages(:child)
    visit page_data.to_path
    accept_confirm { first("a[title='削除']").click }

    click_link '削除の取り消し'
    visit page_data.to_path
    assert_text "child_title"
  end

  test 'page index' do
    visit pages_path

    assert_text "search_text_include_title"
    assert_text "grandparents_title / parents_title / child_title"
  end

  test 'page index with tag parameter' do
    visit pages_path(tag: 'tag1')

    assert_text "tags_page_title"
    assert_no_text "search_text_include_title"
  end

  test 'archive page' do
    page_data = pages(:child)
    visit page_data.to_path

    accept_confirm { first("a[title='アーカイブ']").click }
    assert_text "ページをアーカイブしました"
  end
end
