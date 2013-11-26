(function() {
  playlister_app.controller('PlaylistController', function($scope, $cookieStore, $http, $location, $routeParams, LastfmCharts, RdioPlaylist, RdioCatalog, Notification, PlaylisterConfig) {
    var update_lastfm_user_from_url;
    $scope.lastfm_user = LastfmCharts.user;
    $scope.lastfm_neighbors = LastfmCharts.neighbors;
    $scope.year_charts = LastfmCharts.year_charts;
    $scope.chart = {};
    $scope.playlist = RdioPlaylist.playlist;
    $scope.track_filters = {
      min_play_count: 2
    };
    $scope.chart_filters = {};
    $scope.load_status = LastfmCharts.load_status;
    update_lastfm_user_from_url = function() {
      if ($routeParams.user !== $cookieStore.get('lastfm_user')) {
        $cookieStore.put('lastfm_user', $routeParams.user);
        LastfmCharts.reset_charts();
      }
      return $scope.lastfm_user.user_name = $cookieStore.get('lastfm_user');
    };
    $scope.reset_playlist = function() {
      return RdioPlaylist.reset_playlist();
    };
    $scope.go_to_weeks_list = function() {
      return $location.path("/lastfm/" + $scope.lastfm_user.user_name);
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
      var user_name;
      update_lastfm_user_from_url();
      if (LastfmCharts.year_charts < 1) {
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
    $scope.lastfm_tracks = function() {
      var user_name;
      update_lastfm_user_from_url();
      $scope.chart = LastfmCharts.get_chart($routeParams.from, $routeParams.to);
      user_name = $scope.lastfm_user.user_name;
      if ($scope.lastfm_user.real_name) {
        user_name = $scope.lastfm_user.real_name + (" (" + user_name + ")");
      }
      $scope.playlist.description = 'Last.fm track chart for ' + ("" + user_name + " for " + ($scope.chart.to_s()) + ".");
      LastfmCharts.get_weekly_track_chart($scope.lastfm_user.user_name, $scope.chart);
      return $scope.$watch('chart.loaded', function() {
        return $scope.update_playlist_name();
      });
    };
    $scope.update_playlist_name = function() {
      var min_play_count;
      min_play_count = $scope.track_filters.min_play_count;
      return $scope.playlist.name = $scope.chart.playlist_name(min_play_count);
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
