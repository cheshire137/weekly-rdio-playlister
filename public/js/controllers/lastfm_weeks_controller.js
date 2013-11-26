(function() {
  playlister_app.controller('LastfmWeeksController', function($scope, $routeParams, $cookieStore, Notification, LastfmCharts) {
    $scope.lastfm_user = LastfmCharts.user;
    $scope.load_status = LastfmCharts.load_status;
    $scope.year_charts = LastfmCharts.year_charts;
    $scope.lastfm_neighbors = LastfmCharts.neighbors;
    $scope.chart_filters = {};
    $scope.init = function() {
      var user_name;
      if ($routeParams.user !== $cookieStore.get('lastfm_user')) {
        $cookieStore.put('lastfm_user', $routeParams.user);
        LastfmCharts.reset_charts();
      }
      $scope.lastfm_user.user_name = $cookieStore.get('lastfm_user');
      if (!$scope.load_status.charts) {
        user_name = $scope.lastfm_user.user_name;
        LastfmCharts.get_user_info(user_name);
        $scope.$watch('lastfm_user.date_registered', function() {
          var cutoff_date;
          cutoff_date = $scope.lastfm_user.date_registered;
          return LastfmCharts.get_weekly_chart_list_after_date(user_name, cutoff_date);
        });
        return LastfmCharts.get_user_neighbors(user_name);
      }
    };
    $scope.wipe_notifications = function() {
      return Notification.wipe_notifications();
    };
    return $scope.chart_year_filter = function(year_chart) {
      if (!$scope.chart_filters.year_chart) {
        return true;
      }
      return year_chart.year === $scope.chart_filters.year_chart.year;
    };
  });

}).call(this);
