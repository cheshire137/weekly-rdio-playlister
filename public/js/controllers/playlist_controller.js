(function() {
  playlister_app.controller('PlaylistController', function($scope, Lastfm, LastfmCharts, PlaylisterConfig) {
    var on_error;
    $scope.lastfm = {};
    $scope.weeks = LastfmCharts.weeks;
    on_error = function(response) {
      return console.error(response);
    };
    $scope.get_weekly_chart_list = function() {
      return LastfmCharts.get_weekly_chart_list($scope.lastfm.user, on_error);
    };
    return $scope.get_weekly_track_chart = function(chart) {
      return LastfmCharts.get_weekly_track_chart($scope.lastfm.user, chart, on_error);
    };
  });

}).call(this);
