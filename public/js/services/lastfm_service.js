(function() {
  playlister_app.factory('Lastfm', function(PlaylisterConfig) {
    var Lastfm;
    Lastfm = (function() {
      function Lastfm() {
        this.api_url = 'http://ws.audioscrobbler.com/2.0/';
      }

      Lastfm.prototype.get_api_url = function(method, params) {
        var key, url, value;
        url = this.api_url + '?method=' + method;
        url += '&api_key=' + PlaylisterConfig.api_key + '&format=json';
        for (key in params) {
          value = params[key];
          url += "&" + key + "=" + (encodeURIComponent(value));
        }
        return url;
      };

      Lastfm.prototype.get_weekly_chart_list_url = function(user) {
        return this.get_api_url('user.getweeklychartlist', {
          user: user
        });
      };

      return Lastfm;

    })();
    return new Lastfm();
  });

}).call(this);
