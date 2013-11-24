# Copyright 2013 Sarah Vessels
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

playlister_app.factory 'RdioPlaylist', ($http, Notification) ->
  class RdioPlaylist
    constructor: ->
      @playlist = {}

    get_playlist_create_url: ->
      '/rdio_playlist_create'

    create: (name, description, tracks) ->
      request_data =
        name: name
        description: description
        tracks: tracks
      on_success = (playlist, status, headers, config) =>
        for key, value of playlist
          @playlist[key] = value
      on_error = (data, status, headers, config) =>
        Notification.error data
      $http(
        url: @get_playlist_create_url()
        method: 'POST'
        data: request_data
      ).success(on_success).error(on_error)

  new RdioPlaylist()
