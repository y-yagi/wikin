# Be sure to restart your server when you modify this file. Action Cable runs in a loop that does not support auto reloading.
class PageChannel < ApplicationCable::Channel
  def subscribed
    @page = Page.find(params[:id])
    stream_for(@page)
    PageChannel.broadcast_to @page, { connection_count: ActionCable.server.connections.count }
  end

  def unsubscribed
    PageChannel.broadcast_to @page, { connection_count: ActionCable.server.connections.count }
  end
end
