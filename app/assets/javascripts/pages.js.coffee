$ ->
  $("#page_parent_id").autocomplete('/pages/titles.json', {
    minChars: 2,
    remoteDataType: 'json'
  })
