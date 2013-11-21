(function() {
  playlister_app.controller('PlaylistController', function($scope, $http, $routeParams, $location, LastfmCharts, RdioPlaylist, RdioCatalog, PlaylisterConfig) {
    $scope.lastfm = {};
    $scope.weeks = LastfmCharts.weeks;
    $scope.chart = {};
    $scope.playlist = {};
    $scope.track_filters = {
      min_play_count: 2
    };
    $scope.week_range = function() {
      var i, range, _i, _ref;
      range = [];
      for (i = _i = 0, _ref = $scope.weeks.length; _i < _ref; i = _i += 3) {
        range.push(i);
      }
      return range;
    };
    $scope.play_count_filter = function(track) {
      return track.play_count >= $scope.track_filters.min_play_count;
    };
    $scope.lastfm_weeks = function() {
      $scope.lastfm.user = $routeParams.user;
      return LastfmCharts.get_weekly_chart_list($scope.lastfm.user);
    };
    $scope.lastfm_tracks = function() {
      $scope.lastfm.user = $routeParams.user;
      $scope.chart = new LastfmChart({
        from: $routeParams.from,
        to: $routeParams.to
      });
      LastfmCharts.get_weekly_track_chart($scope.lastfm.user, $scope.chart);
      $scope.playlist.name = $scope.chart.to_s();
      return $scope.playlist.description = 'Last.fm track chart for user ' + ("" + $scope.lastfm.user + " for ") + ("" + ($scope.chart.to_s()) + ".");
    };
    return $scope.create_playlist = function() {
      console.log('create_playlist');
      return RdioCatalog.match_lastfm_tracks($scope.chart.tracks, function(rdio_tracks) {
        var on_playlist_create, track, track_ids, track_ids_str;
        console.log(rdio_tracks);
        track_ids = (function() {
          var _i, _len, _results;
          _results = [];
          for (_i = 0, _len = rdio_tracks.length; _i < _len; _i++) {
            track = rdio_tracks[_i];
            _results.push(track.id);
          }
          return _results;
        })();
        console.log(track_ids);
        track_ids_str = track_ids.join(',');
        console.log(track_ids_str);
        on_playlist_create = function(playlist) {
          var plural;
          plural = playlist.song_count === 1 ? '' : 's';
          Notification.notice('Successfully created playlist with ' + ("" + playlist.song_count + " track" + plural + "!"));
          return $location.path("/lastfm/" + $scope.lastfm.user);
        };
        return RdioPlaylist.create($scope.playlist.name, $scope.playlist.description, track_ids_str, on_playlist_create);
      });
    };
  });

}).call(this);
