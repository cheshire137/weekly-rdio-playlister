playlister_app.controller 'PlaylistController', ($scope, $http, $routeParams, LastfmCharts, PlaylisterConfig) ->
  $scope.lastfm = {}
  $scope.weeks = LastfmCharts.weeks
  $scope.chart = {}
  $scope.playlist = {}

  on_error = (message) ->
    $scope.error = message

  $scope.week_range = ->
    range = []
    for i in [0...$scope.weeks.length] by 3
      range.push i
    range

  $scope.get_weekly_chart_list = ->
    LastfmCharts.get_weekly_chart_list($scope.lastfm.user, on_error)

  $scope.get_weekly_track_chart = (chart) ->
    $scope.chart = chart
    LastfmCharts.get_weekly_track_chart($scope.lastfm.user, $scope.chart,
                                        on_error)
    $scope.playlist.name = chart.to_s()

  on_track_lookup = (track_id) ->
    console.log 'on_track_lookup'
    on_success = (data, status, headers, config) =>
      console.log data
    request_data =
      name: $scope.playlist.name
      description: 'test playlist please ignore'
      tracks: track_id
    console.log request_data
    $http(
      url: '/rdio_playlist_create'
      method: 'POST'
      data: request_data
    ).success(on_success).error(on_error)

  $scope.create_playlist = ->
    track = $scope.chart.tracks[0]
    console.log track
    query = track.artist + ' ' + track.name
    console.log query
    on_success = (data, status, headers, config) =>
      console.log data
      if data.error
        console.error data.error
        on_error data.error
      else
        on_track_lookup data.track_id
    $http(
      url: '/rdio_track_search?query=' + encodeURIComponent(query)
      method: 'GET'
    ).success(on_success).error(on_error)
