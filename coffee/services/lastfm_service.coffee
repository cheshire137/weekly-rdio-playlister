playlister_app.factory 'Lastfm', (PlaylisterConfig) ->
  class Lastfm
    constructor: ->
      @api_url = 'http://ws.audioscrobbler.com/2.0/'

    get_api_url: (method, params) ->
      url = @api_url + '?method=' + method
      url += '&api_key=' + PlaylisterConfig.lastfm_api_key + '&format=json'
      for key, value of params
        url += "&#{key}=#{encodeURIComponent(value)}"
      url

    get_weekly_chart_list_url: (user) ->
      @get_api_url 'user.getweeklychartlist',
        user: user

    get_weekly_track_chart_url: (user, chart) ->
      @get_api_url 'user.getweeklytrackchart',
        user: user
        from: chart.from
        to: chart.to

  new Lastfm()
