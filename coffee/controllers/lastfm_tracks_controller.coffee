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

playlister_app.controller 'LastfmTracksController', ($scope, $routeParams, $cookieStore, $location, Notification, RdioPlaylist, RdioCatalog, LastfmCharts) ->
  $scope.lastfm_user = LastfmCharts.user
  $scope.chart = LastfmCharts.chart
  $scope.playlist = RdioPlaylist.playlist
  $scope.load_status = LastfmCharts.load_status
  $scope.track_filters = {min_play_count: 2}

  get_playlist_description = ->
    user_name = $scope.lastfm_user.user_name
    if $scope.lastfm_user.real_name
      user_name = $scope.lastfm_user.real_name + " (#{user_name})"
    "Last.fm track chart for #{user_name} for #{$scope.chart.to_s()}."

  set_playlist_name = ->
    min_play_count = $scope.track_filters.min_play_count
    $scope.playlist.name = $scope.chart.playlist_name(min_play_count)

  $scope.init = ->
    if $routeParams.user != $cookieStore.get('lastfm_user')
      $cookieStore.put('lastfm_user', $routeParams.user)
      LastfmCharts.reset_charts()
    $scope.lastfm_user.user_name = $cookieStore.get('lastfm_user')
    LastfmCharts.load_chart($routeParams.from, $routeParams.to)
    $scope.$watch 'chart.to', ->
      $scope.playlist.description = get_playlist_description()
      LastfmCharts.get_weekly_track_chart($scope.lastfm_user.user_name)
    $scope.$watch 'load_status.chart', ->
      set_playlist_name()
    $scope.$watch 'track_filters.min_play_count', ->
      set_playlist_name()

  $scope.play_count_filter = (track) ->
    track.play_count >= $scope.track_filters.min_play_count

  $scope.create_playlist = ->
    RdioCatalog.match_lastfm_tracks $scope.filtered_tracks, (rdio_tracks) ->
      track_ids = (track.id for track in rdio_tracks)
      track_ids_str = track_ids.join(',')
      RdioPlaylist.create($scope.playlist.name, $scope.playlist.description,
                          track_ids_str)

  $scope.reset_playlist = ->
    RdioPlaylist.reset_playlist()

  $scope.wipe_notifications = ->
    Notification.wipe_notifications()
