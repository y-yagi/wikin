class IndexController < ApplicationController
  def index
    #@pages = Page.root
    @pages = Page.all
  end
end
