(function() {
  playlister_app.controller('PlaylistController', function($scope, $cookieStore, $http, $location, $routeParams, LastfmCharts, RdioPlaylist, RdioCatalog, Notification, PlaylisterConfig) {
    var update_lastfm_user_from_url;
    $scope.lastfm = {};
    $scope.year_charts = LastfmCharts.year_charts;
    $scope.chart = {};
    $scope.playlist = RdioPlaylist.playlist;
    $scope.track_filters = {
      min_play_count: 2
    };
    $scope.chart_filters = {};
    update_lastfm_user_from_url = function() {
      if ($routeParams.user !== $cookieStore.get('lastfm_user')) {
        $cookieStore.put('lastfm_user', $routeParams.user);
        LastfmCharts.reset_charts();
      }
      return $scope.lastfm.user = $cookieStore.get('lastfm_user');
    };
    $scope.reset_playlist = function() {
      return RdioPlaylist.reset_playlist();
    };
    $scope.go_to_weeks_list = function() {
      return $location.path("/lastfm/" + $scope.lastfm.user);
    };
    $scope.wipe_notifications = function() {
      return Notification.wipe_notifications();
    };
    $scope.chart_year_filter = function(year_chart) {
      if (!$scope.chart_filters.year_chart) {
        return true;
      }
      return year_chart.year === $scope.chart_filters.year_chart.year;
    };
    $scope.play_count_filter = function(track) {
      return track.play_count >= $scope.track_filters.min_play_count;
    };
    $scope.lastfm_weeks = function() {
      update_lastfm_user_from_url();
      if (LastfmCharts.year_charts < 1) {
        return LastfmCharts.get_weekly_chart_list($scope.lastfm.user);
      }
    };
    $scope.lastfm_tracks = function() {
      update_lastfm_user_from_url();
      $scope.chart = LastfmCharts.get_chart($routeParams.from, $routeParams.to);
      LastfmCharts.get_weekly_track_chart($scope.lastfm.user, $scope.chart);
      $scope.playlist.name = $scope.chart.to_s();
      return $scope.playlist.description = 'Last.fm track chart for user ' + ("" + $scope.lastfm.user + " for ") + ("" + ($scope.chart.to_s()) + ".");
    };
    return $scope.create_playlist = function() {
      return RdioCatalog.match_lastfm_tracks($scope.filtered_tracks, function(rdio_tracks) {
        var track, track_ids, track_ids_str;
        track_ids = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = rdio_tracks.length; _i < _len; _i++) {
            track = rdio_tracks[_i];
            _results.push(track.id);
          }
          return _results;
        })();
        track_ids_str = track_ids.join(',');
        return RdioPlaylist.create($scope.playlist.name, $scope.playlist.description, track_ids_str);
      });
    };
  });

}).call(this);
