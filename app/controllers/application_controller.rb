class ApplicationController < ActionController::Base
  # Prevent CSRF attacks by raising an exception.
  # For APIs, you may want to use :null_session instead.
  protect_from_forgery with: :exception
  if ENV['BASIC_AUTH_USER'].present? && ENV['BASIC_AUTH_PASSWORD'].present?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'],
      password: ENV['BASIC_AUTH_PASSWORD'], realm: 'Enter username and password.'
  end

  def set_redcarpet
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
  end
end
