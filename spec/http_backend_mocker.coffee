http_backend_mocker =
  mock_e2e_routes: (http_backend) ->
    http_backend.when('GET', '/rdio_login.html').passThrough()
    http_backend.when('GET', '/lastfm_tracks.html').passThrough()
    http_backend.when('GET', '/lastfm_user.html').passThrough()
    http_backend.when('GET', '/lastfm_weeks.html').passThrough()

  mock_shared_routes: (http_backend) ->
    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklychartlist&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=cheshire137').respond
      weeklychartlist:
        chart: [
          {"#text": "", from: "1108296002", to: "1108900802"}
          {"#text": "", from: "1108900801", to: "1109505601"}
        ]
        "@attr":
          user: "cheshire137"

(exports ? this).http_backend_mocker = http_backend_mocker
