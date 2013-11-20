(function() {
  playlister_app.controller('PlaylistController', function($scope, $http, $routeParams, LastfmCharts, PlaylisterConfig) {
    var on_error, on_track_lookup;
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
      return $scope.playlist.name = chart.to_s();
    };
    on_track_lookup = function(track_id) {
      var on_success, request_data,
        _this = this;
      console.log('on_track_lookup');
      on_success = function(data, status, headers, config) {
        return console.log(data);
      };
      request_data = {
        name: $scope.playlist.name,
        description: 'test playlist please ignore',
        tracks: track_id
      };
      console.log(request_data);
      return $http({
        url: '/rdio_playlist_create',
        method: 'POST',
        data: request_data
      }).success(on_success).error(on_error);
    };
    return $scope.create_playlist = function() {
      var on_success, query, track,
        _this = this;
      track = $scope.chart.tracks[0];
      console.log(track);
      query = track.artist + ' ' + track.name;
      console.log(query);
      on_success = function(data, status, headers, config) {
        console.log(data);
        if (data.error) {
          console.error(data.error);
          return on_error(data.error);
        } else {
          return on_track_lookup(data.track_id);
        }
      };
      return $http({
        url: '/rdio_track_search?query=' + encodeURIComponent(query),
        method: 'GET'
      }).success(on_success).error(on_error);
    };
  });

}).call(this);
