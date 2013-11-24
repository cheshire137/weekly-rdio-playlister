(function() {
  playlister_app.controller('PageController', function($scope, RdioPlaylist) {
    $scope.playlist = RdioPlaylist.playlist;
    return $scope.reset_playlist = function() {
      return RdioPlaylist.reset_playlist();
    };
  });

}).call(this);
