require 'test_helper'

class OldPageTest < ActiveSupport::TestCase
  test 'create old page when create page' do
    p = Page.create!(title: 'test', body: 'test')
    assert_not p.old_page
  end

  test 'old page has page body before update' do
    p = Page.create!(title: 'test', body: 'test')
    p.update!(body: 'update')
    assert_equal 'test', p.old_page.body
  end
end
