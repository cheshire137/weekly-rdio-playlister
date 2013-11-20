(function() {
  playlister_app.factory('RdioCatalog', function($http) {
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

      RdioCatalog.prototype.search_tracks_by_artist = function(artist_id, track_name, callback, on_error) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          if (data.error) {
            return on_error(data.error);
          } else {
            return callback(data);
          }
        };
        console.log(this.get_track_search_url(artist_id, track_name));
        return $http({
          url: this.get_track_search_url(artist_id, track_name),
          method: 'GET'
        }).success(on_success).error(on_error);
      };

      RdioCatalog.prototype.search_artists = function(artist_name, callback, on_error) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          if (data.error) {
            return on_error(data.error);
          } else {
            return callback(data);
          }
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
