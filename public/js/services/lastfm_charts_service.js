(function() {
  playlister_app.factory('LastfmCharts', function($http, Notification, Lastfm) {
    var LastfmCharts;
    LastfmCharts = (function() {
      function LastfmCharts() {
        this.weeks = [];
      }

      LastfmCharts.prototype.reset_weeks = function() {
        var i, _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = this.weeks.length; _i < _ref; i = _i += 1) {
          _results.push(delete this.weeks[i]);
        }
        return _results;
      };

      LastfmCharts.prototype.get_weekly_chart_list = function(user) {
        var on_success,
          _this = this;
        this.reset_weeks();
        on_success = function(data, status, headers, config) {
          var chart_data, _i, _len, _ref, _results;
          if (data.weeklychartlist) {
            _ref = data.weeklychartlist.chart.slice(0).reverse();
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              chart_data = _ref[_i];
              _results.push(_this.weeks.push(new LastfmChart(chart_data)));
            }
            return _results;
          } else if (data.error) {
            return Notification.error(data.message);
          }
        };
        return $http({
          url: Lastfm.get_weekly_chart_list_url(user),
          method: 'GET'
        }).success(on_success).error(function(data, status, headers, config) {
          return Notification.error(data);
        });
      };

      LastfmCharts.prototype.get_weekly_track_chart = function(user, chart) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var track_data, _i, _len, _ref, _results;
          if (data.weeklytrackchart.track) {
            _ref = data.weeklytrackchart.track;
            _results = [];
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              track_data = _ref[_i];
              _results.push(chart.tracks.push(new LastfmTrack(track_data)));
            }
            return _results;
          } else {
            return Notification.error("No tracks for the week of " + (chart.to_s()) + ".");
          }
        };
        return $http({
          url: Lastfm.get_weekly_track_chart_url(user, chart),
          method: 'GET'
        }).success(on_success).error(function(data, status, headers, config) {
          return Notification.error(data);
        });
      };

      return LastfmCharts;

    })();
    return new LastfmCharts();
  });

}).call(this);
