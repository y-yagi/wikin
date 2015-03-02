class PagesController < ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy, :undo]
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
        msg = messages(:update_page) +
          "#{view_context.link_to(messages(:undo_page_link), undo_page_path(@page))}"
        redirect_to @page.to_path, info: msg
      end
    else
      if request.format.json?
        @status = :unprocessable_entity
      else
        render :edit
      end
    end
  end

  def undo
    @page.undo!
    redirect_to @page.to_path, info: messages(:undo_page)
  end

  def destroy
    unless @page.can_destory?
      return redirect_to @page.to_path, warning: messages(:have_child_page)
    end

    @page.destroy

    msg = messages(:destroy_page) +
      "#{view_context.link_to(messages(:restore_page_link), restore_page_path(@page))}"
    redirect_to root_url, info: msg
  end

  def restore
    Page.restore(params[:id])
    flash[:info] = messages(:restore_page)
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

  def preview
    set_redcarpet
    @markdown_body = @markdown.render(params[:page_body]).html_safe
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :body, :parent_id, :parent_name)
    end
end
