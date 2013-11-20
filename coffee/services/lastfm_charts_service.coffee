playlister_app.factory 'LastfmCharts', ($http, Lastfm) ->
  class LastfmCharts
    constructor: ->
      @weeks = []

    get_weekly_chart_list: (user, on_error) ->
      on_success = (data, status, headers, config) =>
        for chart_data in data.weeklychartlist.chart
          @weeks.push(new LastfmChart(chart_data))
      $http(
        url: Lastfm.get_weekly_chart_list_url(user)
        method: 'GET'
      ).success(on_success).error(on_error)

    get_weekly_track_chart: (user, chart, on_error) ->
      on_success = (data, status, headers, config) =>
        console.log data
        for track_data in data.weeklytrackchart.track
          chart.tracks.push(new LastfmTrack(track_data))
        console.log chart.tracks
      $http(
        url: Lastfm.get_weekly_track_chart_url(user, chart)
        method: 'GET'
      ).success(on_success).error(on_error)

  new LastfmCharts()
