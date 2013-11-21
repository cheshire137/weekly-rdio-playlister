(function() {
  playlister_app.factory('RdioCatalog', function($http, Notification) {
    var RdioCatalog;
    RdioCatalog = (function() {
      function RdioCatalog() {}

      RdioCatalog.prototype.get_artist_search_url = function(artist_name) {
        return "/rdio_artist_search?query=" + artist_name;
      };

      RdioCatalog.prototype.get_track_search_url = function(artist_id, track_name) {
        var query;
        query = encodeURIComponent(track_name);
        return "/rdio_track_search?artist_id=" + artist_id + "&query=" + query;
      };

      RdioCatalog.prototype.match_lastfm_track = function(index, lastfm_tracks, rdio_tracks, callback) {
        var lastfm_track, on_rdio_track,
          _this = this;
        lastfm_track = lastfm_tracks[index];
        on_rdio_track = function(rdio_track) {
          if (rdio_track) {
            console.log("got Rdio track #" + index + ": ", rdio_track);
            rdio_tracks.push(rdio_track);
          }
          if (index < lastfm_tracks.length - 1) {
            return _this.match_lastfm_track(index + 1, lastfm_tracks, rdio_tracks, callback);
          } else {
            console.log('finished matching!');
            return callback(rdio_tracks);
          }
        };
        return this.search_artists(lastfm_track.artist, function(artist) {
          if (artist) {
            console.log("found Rdio artist: ", artist);
            return _this.search_tracks_by_artist(artist.id, lastfm_track.name, on_rdio_track);
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
            Notification.error(data.error);
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
            Notification.error(data.error);
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
