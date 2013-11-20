(function() {
  playlister_app.controller('PlaylistController', function($scope, Lastfm, PlaylisterConfig) {
    $scope.lastfm = {};
    return $scope.get_weeks = function() {
      var url;
      url = Lastfm.get_weekly_chart_list_url($scope.lastfm.user);
      return console.log(url);
    };
  });

}).call(this);
