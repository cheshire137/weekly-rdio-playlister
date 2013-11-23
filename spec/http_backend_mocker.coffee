http_backend_mocker =
  mock_e2e_routes: (http_backend) ->
    http_backend.when('GET', '/rdio_login.html').passThrough()
    http_backend.when('GET', '/lastfm_tracks.html').passThrough()
    http_backend.when('GET', '/lastfm_user.html').passThrough()
    http_backend.when('GET', '/lastfm_weeks.html').passThrough()

  mock_shared_routes: (http_backend) ->

(exports ? this).http_backend_mocker = http_backend_mocker
