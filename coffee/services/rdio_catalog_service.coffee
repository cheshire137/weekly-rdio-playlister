playlister_app.factory 'RdioCatalog', ($http, Notification) ->
  class RdioCatalog
    get_artist_search_url: (artist_name) ->
      "/rdio_artist_search?query=#{artist_name}"

    get_track_search_url: (artist_id, track_name) ->
      query = encodeURIComponent(track_name)
      "/rdio_track_search?artist_id=#{artist_id}&query=#{query}"

    search_tracks_by_artist: (artist_id, track_name, callback) ->
      on_success = (data, status, headers, config) =>
        if data.error
          Notification.error data.error
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
        else
          callback data
      on_error = (data, status, headers, config) =>
        Notification.error data
      $http(
        url: @get_artist_search_url(artist_name)
        method: 'GET'
      ).success(on_success).error(on_error)

  new RdioCatalog()
