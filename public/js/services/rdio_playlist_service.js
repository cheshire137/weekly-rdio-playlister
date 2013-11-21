(function() {
  playlister_app.factory('RdioPlaylist', function($http, Notification) {
    var RdioPlaylist;
    RdioPlaylist = (function() {
      function RdioPlaylist() {}

      RdioPlaylist.prototype.get_playlist_create_url = function() {
        return '/rdio_playlist_create';
      };

      RdioPlaylist.prototype.create = function(name, description, tracks, callback) {
        var on_error, on_success, request_data,
          _this = this;
        on_success = function(data, status, headers, config) {
          return callback(data);
        };
        request_data = {
          name: name,
          description: description,
          tracks: tracks
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
