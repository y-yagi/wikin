$ ->
  Preview =
    search: (page_body) ->
      defer = $.Deferred()
      $.ajax(
        url: "/pages/preview",
        type: 'POST',
        success: defer.resolve,
        error: defer.reject,
        data: { page_body: page_body }
      )
      defer.promise()


  $('#page_parent_name').autocomplete({
    serviceUrl: '/pages/titles.json',
    triggerSelectOnValidInput: false,
    onSelect: (suggestion) ->
      $('#page_parent_id').val(suggestion.data)
  })

  $('#preview_link').click ->
    page_body = $("#page_body").val()
    Preview.search(page_body)

  $('#edit_link').click ->
    $('#page_body').show()
    $('#preview_link').show()
    $('#preview_body').hide()
    $('#edit_link').hide()
