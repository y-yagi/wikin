# typed: false
require 'test_helper'

class OldPageTest < ActiveSupport::TestCase
  test 'create old page when create page' do
    p = Page.create!(title: 'test', body: 'test')
    assert_not p.old_page
  end

  test 'old page has page body before update' do
    p = Page.create!(title: 'test', body: 'test', tags: %w(tag1 tag2))
    p.update!(body: 'update', tags: %w(update_tag1 update_tag2))
    assert_equal 'test', p.old_page.body
    assert_equal %w(tag1 tag2), p.old_page.tags
  end
end
