playlister_app.factory 'RdioPlaylist', ($http) ->
  class RdioPlaylist
    get_playlist_create_url: ->
      '/rdio_playlist_create'

    create: (name, description, tracks, callback, on_error) ->
      on_success = (data, status, headers, config) =>
        console.log data
        callback data
      request_data =
        name: name
        description: description
        tracks: tracks
      $http(
        url: @get_playlist_create_url()
        method: 'POST'
        data: request_data
      ).success(on_success).error(on_error)

  new RdioPlaylist()
