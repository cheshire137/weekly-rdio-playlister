playlister_app.factory 'RdioCatalog', ($http, Notification) ->
  class RdioCatalog
    get_artist_search_url: (artist_name) ->
      "/rdio_artist_search?query=#{artist_name}"

    get_track_search_url: (artist_id, track_name) ->
      query = encodeURIComponent(track_name)
      "/rdio_track_search?artist_id=#{artist_id}&query=#{query}"

    match_lastfm_track: (index, lastfm_tracks, rdio_tracks, callback) ->
      lastfm_track = lastfm_tracks[index]
      lastfm_track.matching = true
      on_rdio_track = (rdio_track) =>
        lastfm_track.matching = false
        if rdio_track
          lastfm_track.matched = true
          rdio_tracks.push rdio_track
        else
          lastfm_track.missing = true
        if index < lastfm_tracks.length - 1
          @match_lastfm_track index+1, lastfm_tracks, rdio_tracks, callback
        else
          callback(rdio_tracks)
      @search_artists lastfm_track.artist, (artist) =>
        if artist
          @search_tracks_by_artist artist.id, lastfm_track.name, on_rdio_track
        else
          lastfm_track.matching = false
          lastfm_track.missing = true
          @match_lastfm_track index+1, lastfm_tracks, rdio_tracks, callback

    match_lastfm_tracks: (lastfm_tracks, on_matched_all) ->
      @match_lastfm_track 0, lastfm_tracks, [], on_matched_all

    search_tracks_by_artist: (artist_id, track_name, callback) ->
      on_success = (data, status, headers, config) =>
        if data.error
          Notification.error data.error
          callback undefined
        else
          callback data
      on_error = (data, status, headers, config) =>
        Notification.error data
      $http(
        url: @get_track_search_url(artist_id, track_name)
        method: 'GET'
      ).success(on_success).error(on_error)

    search_artists: (artist_name, callback) ->
      on_success = (data, status, headers, config) =>
        if data.error
          Notification.error data.error
          callback undefined
        else
          callback data
      on_error = (data, status, headers, config) =>
        Notification.error data
      $http(
        url: @get_artist_search_url(artist_name)
        method: 'GET'
      ).success(on_success).error(on_error)

  new RdioCatalog()
