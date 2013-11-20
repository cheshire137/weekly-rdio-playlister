(function() {
  playlister_app.config([
    '$routeProvider', function($routeProvider) {
      $routeProvider.when('/', {
        templateUrl: '/index.html',
        controller: playlister_app.PlaylistController
      });
      return $routeProvider.otherwise({
        redirectTo: '/'
      });
    }
  ]);

}).call(this);
