document.addEventListener('turbolinks:load', () => {
  var preview;
  preview = {
    search: function(page_body) {
      var defer;
      defer = $.Deferred();
      $.ajax({
        url: "/pages/preview",
        type: 'POST',
        success: defer.resolve,
        error: defer.reject,
        data: {
          page_body: page_body
        }
      });
      return defer.promise();
    }
  };
  $('#page_parent_name').autocomplete({
    serviceUrl: '/pages/titles.json',
    triggerSelectOnValidInput: false,
    onSelect: function(suggestion) {
      return $('#page_parent_id').val(suggestion.data);
    }
  });
  $('#preview_link').click(function() {
    var page_body;
    page_body = $("#page_body").val();
    return preview.search(page_body);
  });
  $('#edit_link').click(function() {
    $('#page_body').show();
    $('#preview_link').show();
    $('#preview_body').hide();
    return $('#edit_link').hide();
  });

  if (document.querySelector('input[type="tags"]')) {
    var tagsInput = require('tags-input');
    tagsInput(document.querySelector('input[type="tags"]'));
  }
})
