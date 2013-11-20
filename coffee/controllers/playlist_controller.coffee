playlister_app.controller 'PlaylistController', ($scope, Lastfm, LastfmCharts, PlaylisterConfig) ->
  $scope.lastfm = {}
  $scope.weeks = LastfmCharts.weeks

  on_error = (response) ->
    console.error response

  $scope.get_weekly_chart_list = ->
    LastfmCharts.update($scope.lastfm.user, on_error)
