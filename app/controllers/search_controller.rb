class SearchController < ApplicationController
  def index
    @pages = []
    return if params[:q].blank?
    @pages = Page.where("title like ? OR body like ?", "%#{params[:q]}%", "%#{params[:q]}%")
  end
end
