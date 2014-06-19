class IndexController < ApplicationController
  def index
    @pages = Page.root
  end
end
