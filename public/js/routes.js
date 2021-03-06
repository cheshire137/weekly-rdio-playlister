(function() {
  playlister_app.config([
    '$routeProvider', function($routeProvider) {
      $routeProvider.when('/', {
        templateUrl: '/lastfm_user.html',
        controller: playlister_app.PlaylistController
      });
      $routeProvider.when('/lastfm/:user', {
        templateUrl: '/lastfm_weeks.html',
        controller: playlister_app.PlaylistController
      });
      $routeProvider.when('/lastfm/:user/chart/:from/:to', {
        templateUrl: '/lastfm_tracks.html',
        controller: playlister_app.PlaylistController
      });
      $routeProvider.when('/login', {
        templateUrl: '/rdio_login.html',
        controller: playlister_app.PlaylistController
      });
      return $routeProvider.otherwise({
        redirectTo: '/'
      });
    }
  ]);

}).call(this);
