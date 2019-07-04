# typed: false
class SearchController < ApplicationController
  def index
    @pages = []
    return if params[:query].blank?

    set_redcarpet if request.format.json?
    @pages = Page::Search.new(params[:query]).matches
  end
end
