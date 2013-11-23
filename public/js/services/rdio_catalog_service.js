(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  playlister_app.factory('RdioCatalog', function($http, Notification) {
    var RdioCatalog;
    RdioCatalog = (function() {
      function RdioCatalog() {
        this.clean_track_name = __bind(this.clean_track_name, this);
      }

      RdioCatalog.prototype.get_artist_search_url = function(artist_name) {
        var query;
        query = encodeURIComponent(artist_name);
        return "/rdio_artist_search?query=" + query;
      };

      RdioCatalog.prototype.get_track_search_url = function(artist_id, track_name) {
        var query;
        query = encodeURIComponent(track_name);
        return "/rdio_track_search?artist_id=" + artist_id + "&query=" + query;
      };

      RdioCatalog.prototype.strip_after_hyphen = function(str) {
        var hyphen_idx;
        hyphen_idx = str.indexOf(' - ');
        if (hyphen_idx > -1) {
          str = str.substring(0, hyphen_idx);
        }
        return str;
      };

      RdioCatalog.prototype.strip_square_brackets = function(str) {
        var close_sq_bracket_idx, open_sq_bracket_idx;
        open_sq_bracket_idx = str.indexOf('[');
        if (open_sq_bracket_idx > -1) {
          close_sq_bracket_idx = str.indexOf(']', open_sq_bracket_idx);
          if (close_sq_bracket_idx > -1) {
            str = str.substring(0, open_sq_bracket_idx) + str.substring(close_sq_bracket_idx + 1);
          } else {
            str = str.substring(0, open_sq_bracket_idx);
          }
        }
        return str;
      };

      RdioCatalog.prototype.strip_parentheses = function(str) {
        var close_paren_idx, open_paren_idx;
        open_paren_idx = str.indexOf('(');
        if (open_paren_idx > -1) {
          close_paren_idx = str.indexOf(')', open_paren_idx);
          if (close_paren_idx > -1) {
            str = str.substring(0, open_paren_idx) + str.substring(close_paren_idx + 1);
          } else {
            str = str.substring(0, open_paren_idx);
          }
        }
        return str;
      };

      RdioCatalog.prototype.clean_track_name = function(track_name) {
        var clean_name;
        clean_name = this.strip_after_hyphen(track_name);
        clean_name = this.strip_square_brackets(clean_name);
        clean_name = this.strip_parentheses(clean_name);
        return clean_name.trim();
      };

      RdioCatalog.prototype.match_lastfm_track = function(index, lastfm_tracks, rdio_tracks, callback) {
        var found_rdio_track, lastfm_track, proceed,
          _this = this;
        lastfm_track = lastfm_tracks[index];
        lastfm_track.matching = true;
        proceed = function() {
          if (index < lastfm_tracks.length - 1) {
            return _this.match_lastfm_track(index + 1, lastfm_tracks, rdio_tracks, callback);
          } else {
            return callback(rdio_tracks);
          }
        };
        found_rdio_track = function(rdio_track) {
          lastfm_track.matching = false;
          lastfm_track.matched = true;
          rdio_tracks.push(rdio_track);
          return proceed();
        };
        return this.search_artists(lastfm_track.artist, function(artist) {
          if (artist) {
            return _this.search_tracks_by_artist(artist.id, lastfm_track.name, function(rdio_track) {
              var clean_name;
              if (rdio_track) {
                return found_rdio_track(rdio_track);
              } else {
                clean_name = _this.clean_track_name(lastfm_track.name);
                return _this.search_tracks_by_artist(artist.id, clean_name, function(rdio_track) {
                  if (rdio_track) {
                    return found_rdio_track(rdio_track);
                  } else {
                    lastfm_track.matching = false;
                    lastfm_track.missing = true;
                    return proceed();
                  }
                });
              }
            });
          } else {
            lastfm_track.matching = false;
            lastfm_track.missing = true;
            return proceed();
          }
        });
      };

      RdioCatalog.prototype.match_lastfm_tracks = function(lastfm_tracks, on_matched_all) {
        return this.match_lastfm_track(0, lastfm_tracks, [], on_matched_all);
      };

      RdioCatalog.prototype.search_tracks_by_artist = function(artist_id, track_name, callback) {
        var on_error, on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          if (data.error) {
            console.error(data.error);
            return callback(void 0);
          } else {
            return callback(data);
          }
        };
        on_error = function(data, status, headers, config) {
          return Notification.error(data);
        };
        return $http({
          url: this.get_track_search_url(artist_id, track_name),
          method: 'GET'
        }).success(on_success).error(on_error);
      };

      RdioCatalog.prototype.search_artists = function(artist_name, callback) {
        var on_error, on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          if (data.error) {
            return callback(void 0);
          } else {
            return callback(data);
          }
        };
        on_error = function(data, status, headers, config) {
          return Notification.error(data);
        };
        return $http({
          url: this.get_artist_search_url(artist_name),
          method: 'GET'
        }).success(on_success).error(on_error);
      };

      return RdioCatalog;

    })();
    return new RdioCatalog();
  });

}).call(this);
