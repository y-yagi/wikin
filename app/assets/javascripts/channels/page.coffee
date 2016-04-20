$(document).on('ready turbolinks:load',  ->
  App.page = App.cable.subscriptions.create { channel: "PageChannel", id: $('#page_id').val() },
    connected: ->

    disconnected: ->

    received: (data) ->
      @setTitle(data['connection_count'])

    setTitle: (connectionCount) ->
      console.log(connectionCount)
      if connectionCount > 1
        document.title = "(同時編集中です) Wikin"
      else
        document.title = "Wikin"
)
