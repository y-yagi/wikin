class SearchController < ApplicationController
  def index
    @pages = []
    return if params[:search].blank?

    @query = params[:search]
    @pages = Page.where("title like ? OR body like ?", "%#{@query}%", "%#{@query}%")
  end
end
