http_backend_mocker =
  mock_e2e_routes: (http_backend) ->
    http_backend.when('GET', '/rdio_login.html').passThrough()
    http_backend.when('GET', '/lastfm_tracks.html').passThrough()
    http_backend.when('GET', '/lastfm_user.html').passThrough()
    http_backend.when('GET', '/lastfm_weeks.html').passThrough()

  mock_shared_routes: (http_backend) ->
    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklychartlist&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=validuser').respond
      weeklychartlist:
        chart: [
          {"#text": "", from: "1293364800", to: "1293969600"}
          {"#text": "", from: "1381665600", to: "1382270400"}
        ]
        "@attr":
          user: "validuser"

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklychartlist&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=otheruser').respond
      weeklychartlist:
        chart: [
          {"#text": "", from: "1362312000", to: "1362916800"}
        ]
        "@attr":
          user: "otheruser"

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklychartlist&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=baduser').respond
      error: 6
      message: "No user with that name was found"
      links: []

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getinfo&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=baduser').respond
      error: 6
      message: "No user with that name was found"
      links: []

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getneighbours&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=validuser').respond
      neighbours:
        user: [
          name: "fabuloususer"
          realname: "Fabulous User"
          url: "http://www.last.fm/user/fabuloususer"
          image: [
            {
              "#text": "http://userserve-ak.last.fm/serve/34/02468.jpg"
              size: "small"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/64/02468.jpg"
              size: "medium"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/126/02468.jpg"
              size: "large"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/252/02468.jpg"
              size: "extralarge"
            }
          ]
          match: "0.99724614620209"
        ]

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getneighbours&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=otheruser').respond
      neighbours:
        user: [
          name: "neatouser"
          realname: "Neato User"
          url: "http://www.last.fm/user/neatouser"
          image: [
            {
              "#text": "http://userserve-ak.last.fm/serve/34/13579.jpg"
              size: "small"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/64/13579.jpg"
              size: "medium"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/126/13579.jpg"
              size: "large"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/252/13579.jpg"
              size: "extralarge"
            }
          ]
          match: "0.99724614620209"
        ]

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getneighbours&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=baduser').respond
      error: 6
      message: "No user with that name was found"
      links: []

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getinfo&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=validuser').respond
        user:
          name: "validuser"
          realname: "Valid User"
          image: [
            {
              "#text": "http://userserve-ak.last.fm/serve/34/8675309.jpg"
              size: "small"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/64/8675309.jpg"
              size: "medium"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/126/8675309.jpg"
              size: "large"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/252/8675309.jpg"
              size: "extralarge"
            }
          ]
          url: "http://www.last.fm/user/validuser"
          id: "1234567"
          country: "US"
          age: "83"
          gender: "f"
          subscriber: "0"
          playcount: "11257"
          playlists: "1"
          bootstrap: "0"
          registered:
            "#text": "2007-02-15 22:21"
            unixtime: "1171578067"
        type: "user"

    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getinfo&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=otheruser').respond
        user:
          name: "otheruser"
          realname: "Other User"
          image: [
            {
              "#text": "http://userserve-ak.last.fm/serve/34/12345.jpg"
              size: "small"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/64/12345.jpg"
              size: "medium"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/126/12345.jpg"
              size: "large"
            }
            {
              "#text": "http://userserve-ak.last.fm/serve/252/12345.jpg"
              size: "extralarge"
            }
          ]
          url: "http://www.last.fm/user/otheruser"
          id: "987654"
          country: "US"
          age: "15"
          gender: "m"
          subscriber: "1"
          playcount: "5329"
          playlists: "10"
          bootstrap: "0"
          registered:
            "#text": "2009-10-08 22:21"
            unixtime: "1171578067"
        type: "user"

    http_backend.when('GET', '/rdio_artist_search?query=Ladytron').respond
      id: "r168074"
      name: "Ladytron"

    http_backend.when('GET', '/rdio_artist_search?query=Tegan%20and%20Sara').respond
      id: undefined
      error: "Could not find artist 'Tegan and Sara' on Rdio."

    http_backend.when('GET', '/rdio_track_search?artist_id=r168074&query=International%20Dateline').respond
      id: "t8201449"

    http_backend.when('POST', '/rdio_playlist_create').respond
      name: "October 13-20, 2013"
      song_count: 2
      image_url: "http://m.rdio.com/_is/?aid=184311-0,192425-5,339960-0,417075-0,686933-3,689094-0,689097-0,953300-1,1154602-4&w=200&h=200"
      id: "p7255039"
      url: "http://rd.io/x/QRZlQDMx4b4/"

    # Week with no tracks
    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklytrackchart&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=validuser&from=1293364800&to=1293969600').respond
      weeklytrackchart:
        "#text": "\n"
        user: "validuser"
        from: "1293364800"
        to: "1293969600"

    # Week with tracks
    http_backend.when('GET', 'http://ws.audioscrobbler.com/2.0/?method=user.getweeklytrackchart&api_key=443e72efdc41032a9069d3b0d0e02d2a&format=json&user=validuser&from=1381665600&to=1382270400').respond
      weeklytrackchart:
        "@attr":
          user: "validuser"
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
