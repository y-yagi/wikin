class PageChannel < ApplicationCable::Channel
  def subscribed
    return if params[:id].blank?

    @page = Page.find(params[:id])
    stream_for(@page)
  end

  def unsubscribed
  end
end
