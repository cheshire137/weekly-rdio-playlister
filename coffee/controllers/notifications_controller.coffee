playlister_app.controller 'NotificationsController', ($scope, Notification) ->
  $scope.notices = Notification.notices
  $scope.errors = Notification.errors

  $scope.remove = (notification_type, notification_id) ->
    Notification.remove notification_type, notification_id
