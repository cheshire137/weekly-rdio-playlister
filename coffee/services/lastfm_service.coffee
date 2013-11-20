playlister_app.factory 'Lastfm', (PlaylisterConfig) ->
  class Lastfm
    constructor: ->
      @api_url = 'http://ws.audioscrobbler.com/2.0/'

    get_api_url: (method, params) ->
      url = @api_url + '?method=' + method
      url += '&api_key=' + PlaylisterConfig.api_key + '&format=json'
      for key, value of params
        url += "&#{key}=#{encodeURIComponent(value)}"
      url

    get_weekly_chart_list_url: (user) ->
      @get_api_url 'user.getweeklychartlist',
        user: user

  new Lastfm()
