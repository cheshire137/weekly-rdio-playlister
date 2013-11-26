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

playlister_app.controller 'LastfmWeeksController', ($scope, $routeParams, $cookieStore, Notification, LastfmCharts) ->
  $scope.lastfm_user = LastfmCharts.user
  $scope.load_status = LastfmCharts.load_status
  $scope.year_charts = LastfmCharts.year_charts
  $scope.lastfm_neighbors = LastfmCharts.neighbors
  $scope.chart_filters = {}

  $scope.init = ->
    if $routeParams.user != $cookieStore.get('lastfm_user')
      $cookieStore.put('lastfm_user', $routeParams.user)
      LastfmCharts.reset_charts()
    $scope.lastfm_user.user_name = $cookieStore.get('lastfm_user')
    unless $scope.load_status.charts
      user_name = $scope.lastfm_user.user_name
      LastfmCharts.get_user_info user_name
      $scope.$watch 'lastfm_user.date_registered', ->
        cutoff_date = $scope.lastfm_user.date_registered
        LastfmCharts.get_weekly_chart_list_after_date user_name, cutoff_date
      LastfmCharts.get_user_neighbors user_name

  $scope.wipe_notifications = ->
    Notification.wipe_notifications()

  $scope.chart_year_filter = (year_chart) ->
    return true unless $scope.chart_filters.year_chart
    year_chart.year == $scope.chart_filters.year_chart.year
