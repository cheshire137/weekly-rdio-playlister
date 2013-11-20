playlister_app.controller 'PlaylistController', ($scope, Lastfm, PlaylisterConfig) ->
  $scope.lastfm = {}

  $scope.get_weeks = ->
    url = Lastfm.get_weekly_chart_list_url($scope.lastfm.user)
    console.log url
