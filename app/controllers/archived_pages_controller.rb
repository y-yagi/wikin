# typed: true
class ArchivedPagesController < ApplicationController
  def index
    @pages = ArchivedPage.order(created_at: :DESC)
    fresh_when(@pages)
  end

  def show
    set_redcarpet

    @page = ArchivedPage.find_by(id: params[:id])
    render '404', status: :not_found unless @page
  end

  def destroy
    page = ArchivedPage.find(params[:id])
    page.destroy!

    redirect_to root_url, info: messages(:destroy_page)
  end

  def restore
    page = ArchivedPage.find(params[:id])
    page.restore!

    flash[:info] = messages(:restore_page)
    redirect_to root_url
  end
end
