# Copyright 2013 Sarah Vessels
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

playlister_app.controller 'PlaylistController', ($scope, $http, $routeParams, LastfmCharts, RdioPlaylist, RdioCatalog, Notification, PlaylisterConfig) ->
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
        for key, value of playlist
          $scope.playlist[key] = value
        console.log 'scope playlist is now: ', $scope.playlist
        Notification.notice 'Successfully created playlist with ' +
                            "#{playlist.song_count} track#{plural}!"
      RdioPlaylist.create($scope.playlist.name, $scope.playlist.description,
                          track_ids_str, on_playlist_create)
