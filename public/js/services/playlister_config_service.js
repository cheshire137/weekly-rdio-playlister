(function() {
  playlister_app.factory('PlaylisterConfig', function() {
    var PlaylisterConfig;
    PlaylisterConfig = (function() {
      function PlaylisterConfig() {
        this.lastfm_api_key = '443e72efdc41032a9069d3b0d0e02d2a';
      }

      return PlaylisterConfig;

    })();
    return new PlaylisterConfig();
  });

}).call(this);
