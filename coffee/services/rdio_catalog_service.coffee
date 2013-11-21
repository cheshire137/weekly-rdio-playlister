playlister_app.factory 'RdioCatalog', ($http, Notification) ->
  class RdioCatalog
    get_artist_search_url: (artist_name) ->
      "/rdio_artist_search?query=#{artist_name}"

    get_track_search_url: (artist_id, track_name) ->
      query = encodeURIComponent(track_name)
      "/rdio_track_search?artist_id=#{artist_id}&query=#{query}"

    match_lastfm_track: (index, lastfm_tracks, rdio_tracks, callback) ->
      lastfm_track = lastfm_tracks[index]
      on_rdio_track = (rdio_track) =>
        if rdio_track
          console.log "got rdio track ##{index}: ", rdio_track
          rdio_tracks.push rdio_track
          console.log "there are now #{rdio_tracks.length} matched track(s)"
        if index < lastfm_tracks.length
          console.log 'continuing to match...'
          @match_lastfm_track index+1, lastfm_tracks, rdio_tracks, callback
        else
          console.log 'finished matching!'
          callback(rdio_tracks)
      @search_artists lastfm_track.artist, (artist) =>
        if artist
          console.log "found rdio artist: ", artist
          @search_tracks_by_artist artist.id, lastfm_track.name, on_rdio_track

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
      console.log @get_track_search_url(artist_id, track_name)
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
