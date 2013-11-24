(function() {
  playlister_app.factory('RdioPlaylist', function($http, Notification) {
    var RdioPlaylist;
    RdioPlaylist = (function() {
      function RdioPlaylist() {
        this.playlist = {};
      }

      RdioPlaylist.prototype.get_playlist_create_url = function() {
        return '/rdio_playlist_create';
      };

      RdioPlaylist.prototype.create = function(name, description, tracks) {
        var on_error, on_success, request_data,
          _this = this;
        request_data = {
          name: name,
          description: description,
          tracks: tracks
        };
        on_success = function(playlist, status, headers, config) {
          var key, value, _results;
          _results = [];
          for (key in playlist) {
            value = playlist[key];
            _results.push(_this.playlist[key] = value);
          }
          return _results;
        };
        on_error = function(data, status, headers, config) {
          return Notification.error(data);
        };
        return $http({
          url: this.get_playlist_create_url(),
          method: 'POST',
          data: request_data
        }).success(on_success).error(on_error);
      };

      return RdioPlaylist;

    })();
    return new RdioPlaylist();
  });

}).call(this);
