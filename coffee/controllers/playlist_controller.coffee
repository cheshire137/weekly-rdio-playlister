playlister_app.controller 'PlaylistController', ($scope, Lastfm, LastfmCharts, PlaylisterConfig) ->
  $scope.lastfm = {}
  $scope.weeks = LastfmCharts.weeks
  $scope.chart = {}

  on_error = (message) ->
    $scope.error = message

  $scope.week_range = ->
    range = []
    for i in [0...$scope.weeks.length] by 3
      range.push i
    range

  $scope.get_weekly_chart_list = ->
    LastfmCharts.get_weekly_chart_list($scope.lastfm.user, on_error)

  $scope.get_weekly_track_chart = (chart) ->
    $scope.chart = chart
    LastfmCharts.get_weekly_track_chart($scope.lastfm.user, $scope.chart,
                                        on_error)
