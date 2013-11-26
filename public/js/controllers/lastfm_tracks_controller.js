(function() {
  playlister_app.controller('LastfmTracksController', function($scope, $routeParams, $cookieStore, $location, Notification, RdioPlaylist, RdioCatalog, LastfmCharts) {
    var get_playlist_description, set_playlist_name;
    $scope.lastfm_user = LastfmCharts.user;
    $scope.chart = LastfmCharts.chart;
    $scope.playlist = RdioPlaylist.playlist;
    $scope.load_status = LastfmCharts.load_status;
    $scope.track_filters = {
      min_play_count: 2
    };
    get_playlist_description = function() {
      var user_name;
      user_name = $scope.lastfm_user.user_name;
      if ($scope.lastfm_user.real_name) {
        user_name = $scope.lastfm_user.real_name + (" (" + user_name + ")");
      }
      return "Last.fm track chart for " + user_name + " for " + ($scope.chart.to_s()) + ".";
    };
    set_playlist_name = function() {
      var min_play_count;
      min_play_count = $scope.track_filters.min_play_count;
      return $scope.playlist.name = $scope.chart.playlist_name(min_play_count);
    };
    $scope.init = function() {
      if ($routeParams.user !== $cookieStore.get('lastfm_user')) {
        $cookieStore.put('lastfm_user', $routeParams.user);
        LastfmCharts.reset_charts();
      }
      $scope.lastfm_user.user_name = $cookieStore.get('lastfm_user');
      LastfmCharts.load_chart($routeParams.from, $routeParams.to);
      $scope.$watch('chart.to', function() {
        $scope.playlist.description = get_playlist_description();
        return LastfmCharts.get_weekly_track_chart($scope.lastfm_user.user_name);
      });
      $scope.$watch('load_status.chart', function() {
        return set_playlist_name();
      });
      return $scope.$watch('track_filters.min_play_count', function() {
        return set_playlist_name();
      });
    };
    $scope.play_count_filter = function(track) {
      return track.play_count >= $scope.track_filters.min_play_count;
    };
    $scope.create_playlist = function() {
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
    $scope.reset_playlist = function() {
      return RdioPlaylist.reset_playlist();
    };
    return $scope.wipe_notifications = function() {
      return Notification.wipe_notifications();
    };
  });

}).call(this);
