(function() {
  var playlister_app;

  playlister_app = angular.module('PlaylisterApp', ['ui.bootstrap', 'ngRoute', 'ngCookies']);

  (typeof exports !== "undefined" && exports !== null ? exports : this).playlister_app = playlister_app;

}).call(this);
