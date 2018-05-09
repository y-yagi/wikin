require 'test_helper'

class ArchivePageTest < ActiveSupport::TestCase
  test '#restore!' do
    archived_page = archived_pages(:include_tags)

    archived_page.restore!
    page = Page.find_by!(title: archived_page.title, body: archived_page.body)

    assert_not_equal archived_page.id, page.id
    assert_equal page.tags, archived_page.tags
    assert_equal page.created_at, archived_page.original_created_at
    assert_equal page.updated_at, archived_page.original_updated_at
  end
end
