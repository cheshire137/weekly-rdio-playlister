(function() {
  playlister_app.controller('PlaylistController', function($scope, Lastfm, LastfmCharts, PlaylisterConfig) {
    var on_error;
    $scope.lastfm = {};
    $scope.weeks = LastfmCharts.weeks;
    on_error = function(response) {
      return console.error(response);
    };
    return $scope.get_weekly_chart_list = function() {
      return LastfmCharts.update($scope.lastfm.user, on_error);
    };
  });

}).call(this);
