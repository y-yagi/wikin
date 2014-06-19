class PagesController < ApplicationController
  before_action :set_page, only: [:edit, :update, :destroy]
  before_action :set_root_pages, except: [:destroy]

  def index
    @pages = Page.all.order(:parent_id)
  end

  def show
    paths = URI.unescape(request.path.force_encoding("UTF-8"))
    titles = paths.split('/').select(&:present?)
    @markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, tables: true)
    @page = Page.find_by_titles(titles)
    render '404' unless @page
  end

  def new
    @page = Page.new
  end

  def edit
  end

  def create
    @page = Page.new(page_params)
    respond_to do |format|
      if @page.save
        format.html { redirect_to @page.url }
        format.json { render :show, status: :created, location: @page }
      else
        format.html { render :new }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def update
    respond_to do |format|
      if @page.update(page_params)
        format.html { redirect_to @page, notice: 'Page was successfully updated.' }
        format.json { render :show, status: :ok, location: @page }
      else
        format.html { render :edit }
        format.json { render json: @page.errors, status: :unprocessable_entity }
      end
    end
  end

  def destroy
    @page.destroy
    respond_to do |format|
      format.html { redirect_to pages_url, notice: 'Page was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  def titles
    return [] if params[:q].blank?
    @titles = Page.where('title like ?', "%#{params[:q]}%").pluck(:title)
    render json: @titles
  end

  private
    def set_page
      @page = Page.find(params[:id])
    end

    def page_params
      params.require(:page).permit(:title, :body, :parent_id, :parent_name)
    end

    def set_root_pages
      @root_pages = Page.root
    end
end
