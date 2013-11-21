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

playlister_app.factory 'LastfmCharts', ($http, Notification, Lastfm) ->
  class LastfmCharts
    constructor: ->
      @weeks = []

    get_weekly_chart_list: (user) ->
      on_success = (data, status, headers, config) =>
        for chart_data in data.weeklychartlist.chart.slice(0).reverse()
          @weeks.push(new LastfmChart(chart_data))
      on_error = (data, status, headers, config) =>
        Notification.error data
      $http(
        url: Lastfm.get_weekly_chart_list_url(user)
        method: 'GET'
      ).success(on_success).error(on_error)

    get_weekly_track_chart: (user, chart) ->
      on_success = (data, status, headers, config) =>
        if data.weeklytrackchart.track
          for track_data in data.weeklytrackchart.track
            chart.tracks.push(new LastfmTrack(track_data))
        else
          on_error "No tracks for the week of #{chart.to_s()}."
      on_error = (data, status, headers, config) =>
        Notification.error data
      $http(
        url: Lastfm.get_weekly_track_chart_url(user, chart)
        method: 'GET'
      ).success(on_success).error(on_error)

  new LastfmCharts()
