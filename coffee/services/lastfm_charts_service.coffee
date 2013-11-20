playlister_app.factory 'LastfmCharts', ($http, Lastfm) ->
  class LastfmCharts
    constructor: ->
      @weeks = []

    update: (user, on_error) ->
      console.log 'getting weeks...'
      on_success = (data, status, headers, config) =>
        console.log data.weeklychartlist.chart
        for chart_data in data.weeklychartlist.chart
          @weeks.push(new LastfmChart(chart_data))
        console.log @weeks
      $http(
        url: Lastfm.get_weekly_chart_list_url(user)
        method: 'GET'
      ).success(on_success).error(on_error)

  new LastfmCharts()
