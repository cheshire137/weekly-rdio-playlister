(function() {
  playlister_app.controller('PageController', function($scope, RdioPlaylist) {
    return $scope.playlist = RdioPlaylist.playlist;
  });

}).call(this);
