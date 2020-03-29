import { Controller } from "stimulus";

export default class extends Controller {
  connect() {
    $("#page_parent_name").autocomplete({
      serviceUrl: "/pages/titles.json",
      triggerSelectOnValidInput: false,
      onSelect: function (suggestion) {
        return $("#page_parent_id").val(suggestion.data);
      },
    });

    var tagsInput = require("tags-input");
    tagsInput(document.querySelector('input[type="tags"]'));
  }

  preview() {
    var page_body;
    page_body = $("#page_body").val();
    return this.search(page_body);
  }

  edit() {
    $("#page_body").show();
    $("#preview_link").show();
    $("#preview_body").hide();
    return $("#edit_link").hide();
  }

  search(body) {
    var defer;
    defer = $.Deferred();
    $.ajax({
      url: "/pages/preview",
      type: "POST",
      success: defer.resolve,
      error: defer.reject,
      data: {
        page_body: body,
      },
    });
    return defer.promise();
  }
}
