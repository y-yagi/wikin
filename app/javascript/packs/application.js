require("@rails/ujs").start()
require("turbolinks").start()

var $ = require("jquery")
window.$ = $;

require("bootstrap")
require("devbridge-autocomplete")

require("./pages")
require("./serviceworker-companion")
