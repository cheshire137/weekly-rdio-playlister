(function() {
  playlister_app.factory('Notification', function($timeout) {
    var Notification;
    Notification = (function() {
      function Notification() {
        this.notices = [];
        this.errors = [];
        this.delay = 5000;
      }

      Notification.prototype.remove = function(type, id) {
        var error, idx, notice, _ref, _ref1, _results, _results1;
        if (type === 'error') {
          _ref = this.errors;
          _results = [];
          for (idx in _ref) {
            error = _ref[idx];
            if (error.id === id) {
              _results.push(this.errors.splice(idx, 1));
            }
          }
          return _results;
        } else {
          _ref1 = this.notices;
          _results1 = [];
          for (idx in _ref1) {
            notice = _ref1[idx];
            if (notice.id === id) {
              _results1.push(this.notices.splice(idx, 1));
            }
          }
          return _results1;
        }
      };

      Notification.prototype.error = function(message) {
        var id, self_remove,
          _this = this;
        if (!message) {
          return;
        }
        console.error(message);
        id = this.errors.length + 1;
        self_remove = function() {
          return _this.remove('error', id);
        };
        $timeout(self_remove, this.delay);
        return this.errors.push({
          message: message,
          id: id
        });
      };

      Notification.prototype.notice = function(message) {
        var id, self_remove,
          _this = this;
        if (!message) {
          return;
        }
        id = this.notices.length + 1;
        self_remove = function() {
          return _this.remove('notice', id);
        };
        $timeout(self_remove, this.delay);
        return this.notices.push({
          message: message,
          id: id
        });
      };

      return Notification;

    })();
    return new Notification();
  });

}).call(this);
