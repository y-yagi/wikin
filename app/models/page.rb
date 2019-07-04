# typed: true
require 'models_to_sql'
require 'webrick'

class Page < ApplicationRecord
  extend T::Sig

  acts_as_forest

  has_one :old_page

  RECENT_PAGE_COUNT = 10
  RECENT_PAGE_COUNT_SMT = 10
  INVALID_TITLE_PATTERN = %w(pages search admin user users rails)  # use it in service

  validates :title, length: { in: 1..255 }
  validates :body, presence: true
  validate :check_valid_title
  validate :check_parent_id
  validate :check_title_uniqueness

  before_update :create_old_page

  scope :tag, ->(tag) do
    where('tags @> ARRAY[?]::varchar[]', [tag])
  end

  attr_accessor :parent_name

  class << self
    extend T::Sig

    sig { params(titles: T::Array[String]).returns(T.nilable(Page)) }
    def find_by_titles(titles)
      root = Page.root.find_by(title: titles.shift)
      return nil unless root

      root = Page.find_tree(root)
      return root if titles.empty?
      root.find_child(titles)
    end

    sig { returns(T::Array[[T.untyped, T::Array[Page]]] ) }
    def recently_updated
      pages = order('updated_at DESC').limit(RECENT_PAGE_COUNT)
      pages.group_by{ |p| p.updated_at.to_date }.sort_by{ |k, v| k }.reverse
    end

    sig { params(pages: T::Array[Page]).returns(T::Array[Page]) }
    def sort_by_full_title(pages)
      pages.to_a.sort_by(&:full_title)
    end

    sig { params(id: Integer).returns(Page) }
    def restore!(id)
      old_page = OldPage.find_by!(page_id: id)
      Page.create!(
        title: old_page.title,
        body: old_page.body,
        tags: old_page.tags,
        parent_id: old_page.parent_id
      )
    end
  end

  sig { params(titles: T::Array[String]).returns(T.nilable(Page)) }
  def find_child(titles)
    title = titles.shift
    page = children.find{|p| p.title == title}
    return nil unless page
    if titles.empty?
      page
    else
      page.find_child(titles)
    end
  end

  sig { returns(String) }
  def to_path
    WEBrick::HTTPUtils.escape('/' + (ancestors.reverse.map(&:title) + [title]).join('/'))
  end

  sig { returns(NilClass) }
  def check_valid_title
    errors.add(:title, :cannot_use, invalid: title) if INVALID_TITLE_PATTERN.include?(title)

    Mime::SET.each do |m|
      format =  ".#{m.symbol}"
      if title.end_with?(format)
        errors.add(:title, :cannot_use, invalid: format)
        return
      end
    end
    return
  end

  sig { returns(NilClass) }
  def check_parent_id
    return if parent_name.blank? && parent_id.blank?
    parent_page = Page.find_by(id: parent_id)

    if parent_page.blank?
      errors.add(:parent_name, :not_exist)
      return
    end
    errors.add(:parent_id, :parent_cannnot_appoint_self) if parent_page.id == self.id
    return
  end

  sig { returns(NilClass) }
  def check_title_uniqueness
    return if title.blank? || !title_changed?

    errors.add(:title, :taken) if Page.find_by(parent_id: parent_id, title: title)
    return
  end

  sig { returns(T::Boolean) }
  def can_destory?
    children.empty?
  end

  sig { params(include_self: T::Boolean).returns(String) }
  def full_title(include_self: true)
    return title if ancestors.empty?

    full_title = ancestors.map(&:title).reverse.join(' / ')
    full_title = full_title + ' / ' + title if include_self

    full_title
  end

  sig { returns(T.nilable(T::Boolean)) }
  def create_old_page
    OldPage.find_or_initialize_by(page: self).update!(
      body: body_was, title: title, tags: tags_was,
      parent_id: parent_id, page_id: id
    )
  end

  sig { returns(NilClass) }
  def undo!
    return unless old_page
    update!(body: T.must(old_page).body)
    return
  end

  sig { returns(NilClass) }
  def archive!
    attr = self.attributes

    attr.delete("id")
    attr["original_created_at"] = attr.delete("created_at")
    attr["original_updated_at"] = attr.delete("updated_at")

    ApplicationRecord.transaction do
      ArchivedPage.create!(attr)
      destroy!
    end
    return
  end
end
