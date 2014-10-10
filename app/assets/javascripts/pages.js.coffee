$ ->
  $('#page_parent_name').autocomplete({
    serviceUrl: '/pages/titles.json',
    triggerSelectOnValidInput: false,
    onSelect: (suggestion) ->
      $('#page_parent_id').val(suggestion.data)
  })

  $('#preview_link').click ->
    html = markdown.toHTML($("#page_body").val())
    $('#preview_body').html(html)

    $('#page_body').hide()
    $('#preview_link').hide()
    $('#preview_body').show()
    $('#edit_link').show()

  $('#edit_link').click ->
    $('#page_body').show()
    $('#preview_link').show()
    $('#preview_body').hide()
    $('#edit_link').hide()
