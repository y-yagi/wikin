class SearchController < ApplicationController
  def index
    @pages = []
    return if params[:query].blank?

    if request.format.json?
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    end

    @pages = Page::Search.new(params[:query]).matches
  end
end
