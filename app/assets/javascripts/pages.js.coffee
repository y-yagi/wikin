$ ->
  $('#page_parent_name').autocomplete({
    serviceUrl: '/pages/titles.json',
    triggerSelectOnValidInput: false,
    onSelect: (suggestion) ->
      $('#page_parent_id').val(suggestion.data)
  })
