playlister_app.controller 'PlaylistController', ($scope, $http, $routeParams, $location, LastfmCharts, RdioPlaylist, RdioCatalog, Notification, PlaylisterConfig) ->
  $scope.lastfm = {}
  $scope.weeks = LastfmCharts.weeks
  $scope.chart = {}
  $scope.playlist = {}
  $scope.track_filters = {min_play_count: 2}

  $scope.week_range = ->
    range = []
    for i in [0...$scope.weeks.length] by 3
      range.push i
    range

  $scope.play_count_filter = (track) ->
    track.play_count >= $scope.track_filters.min_play_count

  $scope.lastfm_weeks = ->
    $scope.lastfm.user = $routeParams.user
    LastfmCharts.get_weekly_chart_list($scope.lastfm.user)

  $scope.lastfm_tracks = ->
    $scope.lastfm.user = $routeParams.user
    $scope.chart = new LastfmChart
      from: $routeParams.from
      to: $routeParams.to
    LastfmCharts.get_weekly_track_chart($scope.lastfm.user, $scope.chart)
    $scope.playlist.name = $scope.chart.to_s()
    $scope.playlist.description = 'Last.fm track chart for user ' +
                                  "#{$scope.lastfm.user} for " +
                                  "#{$scope.chart.to_s()}."

  $scope.create_playlist = ->
    RdioCatalog.match_lastfm_tracks $scope.filtered_tracks, (rdio_tracks) ->
      track_ids = (track.id for track in rdio_tracks)
      track_ids_str = track_ids.join(',')
      on_playlist_create = (playlist) ->
        plural = if playlist.song_count == 1 then '' else 's'
        Notification.notice 'Successfully created playlist with ' +
                            "#{playlist.song_count} track#{plural}!"
        $location.path("/lastfm/#{$scope.lastfm.user}")
      RdioPlaylist.create($scope.playlist.name, $scope.playlist.description,
                          track_ids_str, on_playlist_create)
