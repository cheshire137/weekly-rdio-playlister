(function() {
  playlister_app.controller('NotificationsController', function($scope, Notification) {
    $scope.notices = Notification.notices;
    $scope.errors = Notification.errors;
    return $scope.remove = function(notification_type, notification_id) {
      return Notification.remove(notification_type, notification_id);
    };
  });

}).call(this);
