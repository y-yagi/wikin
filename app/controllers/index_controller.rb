class IndexController < ApplicationController
  def index
    set_recently_updated_pages
  end

  def set_recently_updated_pages
    @recently_updated_pages  = Page.recently_updated
  end
end
