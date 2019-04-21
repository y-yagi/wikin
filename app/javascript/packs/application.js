require("@rails/ujs").start();
require("turbolinks").start();

var $ = require("jquery");
window.$ = $;

require("bootstrap");
require("devbridge-autocomplete");

import * as serviceWorker from './serviceWorker';
serviceWorker.register();

import "controllers";
