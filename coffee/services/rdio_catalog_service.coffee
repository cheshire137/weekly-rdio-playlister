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

playlister_app.factory 'RdioCatalog', ($http, Notification) ->
  class RdioCatalog
    get_artist_search_url: (artist_name) ->
      query = encodeURIComponent(artist_name)
      "/rdio_artist_search?query=#{query}"

    get_track_search_url: (artist_id, track_name) ->
      query = encodeURIComponent(track_name)
      "/rdio_track_search?artist_id=#{artist_id}&query=#{query}"

    strip_after_hyphen: (str) ->
      hyphen_idx = str.indexOf(' - ')
      if hyphen_idx > -1
        # I Don't Wanna Care - feat. Jim => I Don't Wanna Care
        str = str.substring(0, hyphen_idx)
      str

    strip_square_brackets: (str) ->
      open_sq_bracket_idx = str.indexOf('[')
      if open_sq_bracket_idx > -1
        # Pharaohs [feat. Roses Gabor] whee => Pharoahs  whee
        close_sq_bracket_idx = str.indexOf(']', open_sq_bracket_idx)
        if close_sq_bracket_idx > -1
          str = str.substring(0, open_sq_bracket_idx) +
                       str.substring(close_sq_bracket_idx + 1)
        else
          str = str.substring(0, open_sq_bracket_idx)
      str

    strip_parentheses: (str) ->
      open_paren_idx = str.indexOf('(')
      if open_paren_idx > -1
        # Pharaohs (feat. Roses Gabor) whee => Pharoahs  whee
        close_paren_idx = str.indexOf(')', open_paren_idx)
        if close_paren_idx > -1
          str = str.substring(0, open_paren_idx) +
                       str.substring(close_paren_idx + 1)
        else
          str = str.substring(0, open_paren_idx)
      str

    clean_track_name: (track_name) =>
      clean_name = @strip_after_hyphen(track_name)
      clean_name = @strip_square_brackets(clean_name)
      clean_name = @strip_parentheses(clean_name)
      clean_name.trim()

    match_lastfm_track: (index, lastfm_tracks, rdio_tracks, callback) ->
      lastfm_track = lastfm_tracks[index]
      lastfm_track.matching = true
      proceed = =>
        if index < lastfm_tracks.length - 1
          @match_lastfm_track index + 1, lastfm_tracks, rdio_tracks, callback
        else
          callback rdio_tracks
      found_rdio_track = (rdio_track) =>
        lastfm_track.matching = false
        lastfm_track.matched = true
        rdio_tracks.push rdio_track
        proceed()
      @search_artists lastfm_track.artist, (artist) =>
        if artist
          @search_tracks_by_artist artist.id, lastfm_track.name, (rdio_track) =>
            if rdio_track
              found_rdio_track rdio_track
            else
              # Attempt 2!
              clean_name = @clean_track_name(lastfm_track.name)
              @search_tracks_by_artist artist.id, clean_name, (rdio_track) =>
                if rdio_track
                  found_rdio_track rdio_track
                else
                  # Too bad :(
                  lastfm_track.matching = false
                  lastfm_track.missing = true
                  proceed()
        else
          lastfm_track.matching = false
          lastfm_track.missing = true
          proceed()

    match_lastfm_tracks: (lastfm_tracks, on_matched_all) ->
      @match_lastfm_track 0, lastfm_tracks, [], on_matched_all

    search_tracks_by_artist: (artist_id, track_name, callback) ->
      on_success = (data, status, headers, config) =>
        if data.error
          console.error data.error
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
