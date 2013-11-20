playlister_app.controller 'PlaylistController', ($scope, Lastfm, LastfmCharts, PlaylisterConfig) ->
  $scope.lastfm = {}
  $scope.weeks = LastfmCharts.weeks

  on_error = (response) ->
    console.error response

  $scope.get_weekly_chart_list = ->
    LastfmCharts.get_weekly_chart_list($scope.lastfm.user, on_error)

  $scope.get_weekly_track_chart = (chart) ->
    LastfmCharts.get_weekly_track_chart($scope.lastfm.user, chart, on_error)
