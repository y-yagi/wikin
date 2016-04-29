class ApplicationController < ActionController::Base
  protect_from_forgery with: :exception
  add_flash_types :info, :warning
  before_action :set_locale
  helper_method :use_action_cable?

  if ENV['BASIC_AUTH_USER'].present? && ENV['BASIC_AUTH_PASSWORD'].present?
    http_basic_authenticate_with name: ENV['BASIC_AUTH_USER'],
      password: ENV['BASIC_AUTH_PASSWORD'], realm: 'Enter username and password.'
  end

  def set_redcarpet
    renderer = Redcarpet::Render::HTML.new(hard_wrap: true)
    @markdown = Redcarpet::Markdown.new(renderer, autolink: true, tables: true)
  end

  def messages(key, message_values = {})
    I18n.t(key, message_values, scope: [:messages])
  end

  def use_action_cable?
    defined?(@use_action_cable) ? @use_action_cable : false
  end

  private
    def set_locale
      I18n.locale = http_accept_language.compatible_language_from(I18n.available_locales)
    end
end
