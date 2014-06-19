class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception

  http_basic_authenticate_with name: ENV["BASIC_AUTH_NAME"], password: ENV["BASIC_AUTH_PASSWORD"]
  before_action :set_recently_updated_pages


  def set_recently_updated_pages
    @recently_updated_pages  = Page.recently_updated
  end
end
