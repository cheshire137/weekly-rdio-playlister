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

playlister_app.controller 'PlaylistController', ($scope, $cookieStore, $http, $location, $routeParams, LastfmCharts, RdioPlaylist, RdioCatalog, Notification, PlaylisterConfig) ->
  $scope.lastfm_user = LastfmCharts.user
  $scope.lastfm_neighbors = LastfmCharts.neighbors
  $scope.year_charts = LastfmCharts.year_charts
  $scope.chart = {}
  $scope.playlist = RdioPlaylist.playlist
  $scope.track_filters = {min_play_count: 2}
  $scope.chart_filters = {}
  $scope.load_status = LastfmCharts.load_status

  update_lastfm_user_from_url = ->
    if $routeParams.user != $cookieStore.get('lastfm_user')
      $cookieStore.put('lastfm_user', $routeParams.user)
      LastfmCharts.reset_charts()
    $scope.lastfm_user.user_name = $cookieStore.get('lastfm_user')

  $scope.reset_playlist = ->
    RdioPlaylist.reset_playlist()

  $scope.go_to_weeks_list = ->
    $location.path("/lastfm/#{$scope.lastfm_user.user_name}")

  $scope.wipe_notifications = ->
    Notification.wipe_notifications()

  $scope.chart_year_filter = (year_chart) ->
    return true unless $scope.chart_filters.year_chart
    year_chart.year == $scope.chart_filters.year_chart.year

  $scope.play_count_filter = (track) ->
    track.play_count >= $scope.track_filters.min_play_count

  $scope.lastfm_weeks = ->
    update_lastfm_user_from_url()
    if LastfmCharts.year_charts < 1
      user_name = $scope.lastfm_user.user_name
      LastfmCharts.get_user_info user_name
      $scope.$watch 'lastfm_user.date_registered', ->
        cutoff_date = $scope.lastfm_user.date_registered
        LastfmCharts.get_weekly_chart_list_after_date user_name, cutoff_date
      LastfmCharts.get_user_neighbors user_name

  $scope.lastfm_tracks = ->
    update_lastfm_user_from_url()
    $scope.chart = LastfmCharts.get_chart($routeParams.from, $routeParams.to)
    user_name = $scope.lastfm_user.user_name
    if $scope.lastfm_user.real_name
      user_name = $scope.lastfm_user.real_name + " (#{user_name})"
    $scope.playlist.description = 'Last.fm track chart for ' +
                                  "#{user_name} for #{$scope.chart.to_s()}."
    LastfmCharts.get_weekly_track_chart($scope.lastfm_user.user_name,
                                        $scope.chart)
    $scope.$watch 'chart.loaded', ->
      $scope.update_playlist_name()

  $scope.update_playlist_name = ->
    min_play_count = $scope.track_filters.min_play_count
    $scope.playlist.name = $scope.chart.playlist_name(min_play_count)

  $scope.create_playlist = ->
    RdioCatalog.match_lastfm_tracks $scope.filtered_tracks, (rdio_tracks) ->
      track_ids = (track.id for track in rdio_tracks)
      track_ids_str = track_ids.join(',')
      RdioPlaylist.create($scope.playlist.name, $scope.playlist.description,
                          track_ids_str)
