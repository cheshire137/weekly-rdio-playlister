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
      @year_charts = []
      @user = {}
      @neighbors = []
      @charts_loaded = false

    on_error: (data, status, headers, config) =>
      Notification.error data

    reset_charts: ->
      for key, value of @user
        delete @user[key]
      for i in [0...@year_charts.length] by 1
        @year_charts.splice(idx, 1) for idx, year of @year_charts
      for i in [0...@neighbors.length] by 1
        @neighbors.splice(idx, 1) for idx, neighbor of @neighbors

    get_chart_from_year_charts: (from, to) ->
      for year_chart in @year_charts
        for chart in year_chart.charts
          if chart.from == from && chart.to == to
            return chart
      return false

    get_chart: (from, to) ->
      chart = @get_chart_from_year_charts(from, to)
      unless chart
        chart = new LastfmChart
          from: from
          to: to
      chart

    get_user_neighbors: (user_name) ->
      on_success = (data, status, headers, config) =>
        if data.neighbours
          for i in [0...Math.min(8, data.neighbours.user.length)] by 1
            user_data = data.neighbours.user[i]
            @neighbors.push new LastfmNeighbor(user_data)
      $http.get(Lastfm.get_user_neighbors_url(user_name)).
            success(on_success).error(@on_error)

    get_user_info: (user_name, callback) ->
      on_success = (data, status, headers, config) =>
        if data.user
          for key, value of new LastfmUser(data.user)
            @user[key] = value
        callback() if callback
      $http.get(Lastfm.get_user_info_url(user_name)).
            success(on_success).
            error (data, status, headers, config) =>
              Notification.error data
              callback() if callback

    get_charts_after_cutoff_date: (charts_data, cutoff_date) ->
      charts = charts_data.map (data) -> new LastfmChart(data)
      charts.filter (chart) -> chart.to_date() >= cutoff_date

    initialize_year_charts: (charts) ->
      for week_chart in charts
        year = week_chart.year()
        year_chart = @year_charts.filter((obj) -> obj.year == year)[0]
        if year_chart
          year_chart.charts.push week_chart
        else
          @year_charts.push
            year: year
            charts: [week_chart]

    get_weekly_chart_list_after_date: (user, cutoff_date) ->
      on_success = (data, status, headers, config) =>
        if data.weeklychartlist
          charts_data = data.weeklychartlist.chart.slice(0).reverse()
          charts = @get_charts_after_cutoff_date(charts_data, cutoff_date)
          @initialize_year_charts charts
        else if data.error
          Notification.error data.message
        @charts_loaded = true
      $http.get(Lastfm.get_weekly_chart_list_url(user)).
            success(on_success).
            error (data, status, headers, config) =>
              Notification.error data
              @charts_loaded = true

    get_weekly_chart_list: (user_name) ->
      @get_user_info user_name, =>
        @get_weekly_chart_list_after_date user_name, @user.date_registered

    get_weekly_track_chart: (user, chart) ->
      on_success = (data, status, headers, config) =>
        if data.weeklytrackchart.track
          for track_data in data.weeklytrackchart.track
            chart.tracks.push(new LastfmTrack(track_data))
        else
          chart.no_tracks = true
        chart.loaded = true
      $http.get(Lastfm.get_weekly_track_chart_url(user, chart)).
            success(on_success).error(@on_error)

  new LastfmCharts()
