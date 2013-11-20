(function() {
  playlister_app.controller('PlaylistController', function($scope, LastfmCharts, PlaylisterConfig) {
    var on_error;
    $scope.lastfm = {};
    $scope.weeks = LastfmCharts.weeks;
    $scope.chart = {};
    on_error = function(message) {
      return $scope.error = message;
    };
    $scope.week_range = function() {
      var i, range, _i, _ref;
      range = [];
      for (i = _i = 0, _ref = $scope.weeks.length; _i < _ref; i = _i += 3) {
        range.push(i);
      }
      return range;
    };
    $scope.get_weekly_chart_list = function() {
      return LastfmCharts.get_weekly_chart_list($scope.lastfm.user, on_error);
    };
    return $scope.get_weekly_track_chart = function(chart) {
      $scope.chart = chart;
      return LastfmCharts.get_weekly_track_chart($scope.lastfm.user, $scope.chart, on_error);
    };
  });

}).call(this);
