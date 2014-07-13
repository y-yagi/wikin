class SearchController < ApplicationController
  def index
    @pages = []
    return if params[:search].blank?

    if request.format.json?
      renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
      @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
    end

    @query = params[:search]
    @pages = Page.where("title like ? OR body like ?", "%#{@query}%", "%#{@query}%")
  end
end
