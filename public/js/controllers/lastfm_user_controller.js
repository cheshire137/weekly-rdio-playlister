(function() {
  playlister_app.controller('LastfmUserController', function($scope, $location, LastfmCharts) {
    $scope.lastfm_user = LastfmCharts.user;
    return $scope.go_to_weeks_list = function() {
      return $location.path("/lastfm/" + $scope.lastfm_user.user_name);
    };
  });

}).call(this);
