class PagesController < ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy]
  protect_from_forgery with: :null_session

  def index
    set_redcarpet
    @pages = if params[:recent_pages]
               Page.order('updated_at DESC').limit(Page::RECENT_PAGE_COUNT_SMT)
             else
               Page.find_forest
             end
    fresh_when(@pages)
  end

  def show
    paths = URI.unescape(request.path.force_encoding("UTF-8"))
    paths = paths.delete('.json') if request.format.json?

    titles = paths.split('/').select(&:present?)
    set_redcarpet

    @page = Page.find_by_titles(titles)
    render '404', status: :not_found unless @page
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    if @page.save
      redirect_to @page.to_path
    else
      render :new
    end
  end

  def update
    if @page.update(page_params)
      if request.format.json?
        @status = :ok
      else
        redirect_to @page.to_path
      end
    else
      if request.format.json?
        @status = :unprocessable_entity
      else
        render :edit
      end
    end
  end

  def destroy
    unless @page.can_destory?
      flash[:warning] =
        "子ページがあるページの削除は出来ません。 " \
        "先に子ページの削除を実施して下さい。 "
      return redirect_to @page.to_path
    end

    @page.destroy
    flash[:info] =
      "ページの削除が完了しました。 " \
      "#{view_context.link_to('削除の取り消し。', restore_page_path(@page))}"
    redirect_to root_url
  end

  def restore
    Page.only_deleted.find(params[:id]).update_attributes!(deleted_at: nil)
    flash[:info] = "ページの復旧が完了しました"
    redirect_to root_url
  end

  def titles
    @pages = []
    return if params[:query].blank?

    @pages = Page.where('title like ?', "%#{params[:query]}%")
  end

  def search
    @pages = []
    return if params[:query].blank?

    set_redcarpet if request.format.json?
    @pages = Page::Search.new(params[:query]).matches
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :body, :parent_id, :parent_name)
    end
end
