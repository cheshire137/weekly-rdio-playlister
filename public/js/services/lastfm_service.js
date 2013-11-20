(function() {
  playlister_app.factory('Lastfm', function(PlaylisterConfig) {
    var Lastfm;
    Lastfm = (function() {
      function Lastfm() {}

      Lastfm.prototype.get_weekly_chart_list_url = function(user) {
        var user_param;
        user_param = encodeURIComponent(user);
        return 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklychartlist&user=' + user_param + '&api_key=' + PlaylisterConfig.api_key + '&format=json';
      };

      return Lastfm;

    })();
    return new Lastfm();
  });

}).call(this);
