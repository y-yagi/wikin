module ApplicationHelper
  def pages_heading
    params[:tag] ?  "「#{params[:tag]}」" : '全ページ'
  end
end
