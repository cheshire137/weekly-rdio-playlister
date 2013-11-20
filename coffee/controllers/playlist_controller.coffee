playlister_app.controller 'PlaylistController', ($scope, $http, $routeParams, LastfmCharts, RdioPlaylist, RdioCatalog, PlaylisterConfig) ->
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
    $scope.playlist.description = 'Last.fm track chart for user ' +
                                  "#{$scope.lastfm.user} for #{chart.to_s()}."

  $scope.create_playlist = ->
    console.log 'create_playlist'
    track = $scope.chart.tracks[0]
    on_artist_lookup = (artist) ->
      console.log artist
      console.log artist.id
      on_track_lookup = (track) ->
        console.log track
        console.log track.id
        on_playlist_create = (playlist) ->
          plural = if playlist.song_count == 1 then '' else 's'
          $scope.notice = 'Successfully created playlist with ' +
                          "#{playlist.song_count} track#{plural}!"
        RdioPlaylist.create($scope.playlist.name, $scope.playlist.description,
                            track.id, on_playlist_create, on_error)
      RdioCatalog.search_tracks_by_artist(artist.id, track.name,
                                          on_track_lookup, on_error)
    RdioCatalog.search_artists(track.artist, on_artist_lookup, on_error)
