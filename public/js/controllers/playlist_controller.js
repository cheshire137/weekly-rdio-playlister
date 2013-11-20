(function() {
  playlister_app.controller('PlaylistController', function($scope, $http, $routeParams, LastfmCharts, RdioPlaylist, RdioCatalog, PlaylisterConfig) {
    $scope.lastfm = {};
    $scope.weeks = LastfmCharts.weeks;
    $scope.chart = {};
    $scope.playlist = {};
    $scope.week_range = function() {
      var i, range, _i, _ref;
      range = [];
      for (i = _i = 0, _ref = $scope.weeks.length; _i < _ref; i = _i += 3) {
        range.push(i);
      }
      return range;
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
      var on_artist_lookup, track;
      console.log('create_playlist');
      track = $scope.chart.tracks[0];
      on_artist_lookup = function(artist) {
        var on_track_lookup;
        on_track_lookup = function(track) {
          var on_playlist_create;
          on_playlist_create = function(playlist) {
            var plural;
            plural = playlist.song_count === 1 ? '' : 's';
            return $scope.notice = 'Successfully created playlist with ' + ("" + playlist.song_count + " track" + plural + "!");
          };
          return RdioPlaylist.create($scope.playlist.name, $scope.playlist.description, track.id, on_playlist_create);
        };
        return RdioCatalog.search_tracks_by_artist(artist.id, track.name, on_track_lookup);
      };
      return RdioCatalog.search_artists(track.artist, on_artist_lookup);
    };
  });

}).call(this);
