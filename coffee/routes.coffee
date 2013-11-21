# Copyright 2013 Sarah Vessels
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

playlister_app.config(['$routeProvider', ($routeProvider) ->
  $routeProvider.when '/',
    templateUrl: '/lastfm_user.html'
    controller: playlister_app.PlaylistController

  $routeProvider.when '/lastfm/:user',
    templateUrl: '/lastfm_weeks.html'
    controller: playlister_app.PlaylistController

  $routeProvider.when '/lastfm/:user/chart/:from/:to',
    templateUrl: '/lastfm_tracks.html'
    controller: playlister_app.PlaylistController

  $routeProvider.when '/login',
    templateUrl: '/rdio_login.html'
    controller: playlister_app.PlaylistController

  $routeProvider.otherwise
    redirectTo: '/'
])
