playlister_app.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/',
    templateUrl: '/index.html'
    controller: playlister_app.PlaylistController

  $routeProvider.otherwise
    redirectTo: '/'
])
