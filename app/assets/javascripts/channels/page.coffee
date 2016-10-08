$(document).on('ready turbolinks:load',  ->
  App.page = App.cable.subscriptions.create { channel: "PageChannel", id: $('#page_id').val() },
    connected: ->

    disconnected: ->

    received: (data) ->
      @displayWarning()

    displayWarning: () ->
      $('#page-update-warning').show()
      $("#page-update-button").prop("disabled", true)
)
