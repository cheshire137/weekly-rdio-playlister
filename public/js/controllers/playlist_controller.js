(function() {
  playlister_app.controller('PlaylistController', function($scope, $http, $routeParams, LastfmCharts, RdioPlaylist, RdioCatalog, PlaylisterConfig) {
    var on_error;
    $scope.lastfm = {};
    $scope.weeks = LastfmCharts.weeks;
    $scope.chart = {};
    $scope.playlist = {};
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
    $scope.get_weekly_track_chart = function(chart) {
      $scope.chart = chart;
      LastfmCharts.get_weekly_track_chart($scope.lastfm.user, $scope.chart, on_error);
      $scope.playlist.name = chart.to_s();
      return $scope.playlist.description = 'Last.fm track chart for user ' + ("" + $scope.lastfm.user + " for " + (chart.to_s()) + ".");
    };
    return $scope.create_playlist = function() {
      var on_artist_lookup, track;
      console.log('create_playlist');
      track = $scope.chart.tracks[0];
      on_artist_lookup = function(artist) {
        var on_track_lookup;
        console.log(artist);
        console.log(artist.id);
        on_track_lookup = function(track) {
          var on_playlist_create;
          console.log(track);
          console.log(track.id);
          on_playlist_create = function(playlist) {
            var plural;
            plural = playlist.song_count === 1 ? '' : 's';
            return $scope.notice = 'Successfully created playlist with ' + ("" + playlist.song_count + " track" + plural + "!");
          };
          return RdioPlaylist.create($scope.playlist.name, $scope.playlist.description, track.id, on_playlist_create, on_error);
        };
        return RdioCatalog.search_tracks_by_artist(artist.id, track.name, on_track_lookup, on_error);
      };
      return RdioCatalog.search_artists(track.artist, on_artist_lookup, on_error);
    };
  });

}).call(this);
