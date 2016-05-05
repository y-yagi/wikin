# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PageChannel < ApplicationCable::Channel
  def subscribed
    return if params[:id].blank?

    @page = Page.find(params[:id])
    stream_for(@page)
  end

  def unsubscribed
  end
end
