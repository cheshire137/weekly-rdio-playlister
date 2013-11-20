(function() {
  playlister_app.factory('RdioPlaylist', function($http) {
    var RdioPlaylist;
    RdioPlaylist = (function() {
      function RdioPlaylist() {}

      RdioPlaylist.prototype.get_playlist_create_url = function() {
        return '/rdio_playlist_create';
      };

      RdioPlaylist.prototype.create = function(name, description, tracks, callback, on_error) {
        var on_success, request_data,
          _this = this;
        on_success = function(data, status, headers, config) {
          console.log(data);
          return callback(data);
        };
        request_data = {
          name: name,
          description: description,
          tracks: tracks
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
