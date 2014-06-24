require 'models_to_sql'
class Page < ActiveRecord::Base
  acts_as_forest
  acts_as_paranoid

  RECENT_PAGE_COUNT = 20
  INVALID_TITLE_PATTERN = %w(pages search admin user users rails)  # サービスで使用するので、使用不可にする

  validates :title, uniqueness_without_deleted: true, length: { in: 1..255 }
  validates :body, presence: true
  validate :check_valid_title
  validate :check_parent_id

  attr_accessor :parent_name

  class << self
    def find_by_titles(titles)
      root = Page.root.find_by(title: titles.shift)

      return nil unless root
      return root if titles.empty?
      root.find_child(titles)
    end

    def recently_updated
      pages = order(:updated_at).limit(RECENT_PAGE_COUNT)
      pages.group_by{ |p| p.updated_at.to_date }.sort_by{ |k, v| k }.reverse
    end
  end

  def find_child(titles)
    title = titles.shift
    page = children.find{|p| p.title == title}
    return nil unless page
    if titles.empty?
      return page
    else
      return page.find_child(titles)
    end
  end

  def to_url
    url = URI.escape('/' + (ancestors.map(&:title) + [title]).join('/'))
  end

  def check_valid_title
    errors.add(:title, :cannot_use) if INVALID_TITLE_PATTERN.include?(title)
  end

  def check_parent_id
    return if parent_name.blank?

    parent_page = Page.find_by(title: parent_name)
    if parent_page.blank?
      errors.add(:parent_name, :not_exist)
    else
      self.parent_id = parent_page.id
    end
  end

end
