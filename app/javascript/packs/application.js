require("@rails/ujs").start()
require("turbolinks").start()

var $ = require("jquery")
window.$ = $;
window.$.autocomplete = require("jquery-ui/ui/widgets/autocomplete")

require("bootstrap")

require("./pages")
require("./serviceworker-companion")
