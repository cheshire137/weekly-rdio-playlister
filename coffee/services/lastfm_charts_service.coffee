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

    reset_weeks: ->
      for i in [0...@weeks.length] by 1
        @weeks.splice(idx, 1) for idx, week of @weeks

    get_weekly_chart_list: (user) ->
      on_success = (data, status, headers, config) =>
        if data.weeklychartlist
          for chart_data in data.weeklychartlist.chart.slice(0).reverse()
            @weeks.push(new LastfmChart(chart_data))
        else if data.error
          Notification.error data.message
      $http(
        url: Lastfm.get_weekly_chart_list_url(user)
        method: 'GET'
      ).success(on_success).error (data, status, headers, config) =>
        Notification.error data

    get_weekly_track_chart: (user, chart) ->
      on_success = (data, status, headers, config) =>
        if data.weeklytrackchart.track
          for track_data in data.weeklytrackchart.track
            chart.tracks.push(new LastfmTrack(track_data))
        else
          Notification.error "No tracks for the week of #{chart.to_s()}."
      $http(
        url: Lastfm.get_weekly_track_chart_url(user, chart)
        method: 'GET'
      ).success(on_success).error (data, status, headers, config) =>
        Notification.error data

  new LastfmCharts()
