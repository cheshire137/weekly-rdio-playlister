playlister_app.factory 'Lastfm', (PlaylisterConfig) ->
  class Lastfm
    get_weekly_chart_list_url: (user) ->
      user_param = encodeURIComponent(user)
      'http://ws.audioscrobbler.com/2.0/?method=user.getweeklychartlist&user=' + user_param + '&api_key=' + PlaylisterConfig.api_key + '&format=json'

  new Lastfm()
