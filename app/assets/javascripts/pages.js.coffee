$ ->
  $("#page_parent_name").autocomplete('/pages/titles.json', {
    minChars: 2,
    remoteDataType: 'json'
  })
