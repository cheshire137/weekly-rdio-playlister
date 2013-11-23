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
          {"#text": "", from: "1381665600", to: "1382270400"}
          {"#text": "", from: "1108900801", to: "1109505601"}
        ]
        "@attr":
          user: "cheshire137"

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklytrackchart&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=cheshire137&from=1381665600&to=1382270400').respond
      weeklytrackchart:
        "@attr":
          user: "cheshire137"
          from: "1381665600"
          to: "1382270400"
        track: [
          {
            artist:
              "#text": "Ladytron"
              mbid: "b45335d1-5219-4262-a44d-936aa36eeaed"
            name: "International Dateline"
            mbid: "b6695955-aefd-4bcb-8ff4-d193bcfeee88"
            playcount: "4"
            image: [
              {
                "#text": "http://userserve-ak.last.fm/serve/34/90093361.png"
                size: "small"
              }
              {
                "#text": "http://userserve-ak.last.fm/serve/64/90093361.png"
                size: "medium"
              }
              {
                "#text": "http://userserve-ak.last.fm/serve/126/90093361.png"
                size: "large"
              }
            ],
            url: "www.last.fm/music/Ladytron/_/International+Dateline"
            "@attr":
              rank: "1"
          }
          {
            artist:
              "#text": "Tegan and Sara"
              mbid: "d13f0f47-36f9-4661-87fe-2de56f45c649"
            name: "Closer"
            mbid: "07436946-4d54-46f7-a2f6-165df3b7348c"
            playcount: "3"
            image: [
              {
                "#text": "http://userserve-ak.last.fm/serve/34/48948745.png"
                size: "small"
              }
              {
                "#text": "http://userserve-ak.last.fm/serve/64/48948745.png"
                size: "medium"
              }
              {
                "#text": "http://userserve-ak.last.fm/serve/126/48948745.png"
                size: "large"
              }
            ]
            url: "www.last.fm/music/Tegan+and+Sara/_/Closer"
            "@attr":
              rank: "2"
          }
        ]

(exports ? this).http_backend_mocker = http_backend_mocker
