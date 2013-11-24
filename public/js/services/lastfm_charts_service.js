(function() {
  playlister_app.factory('LastfmCharts', function($http, Notification, Lastfm) {
    var LastfmCharts;
    LastfmCharts = (function() {
      function LastfmCharts() {
        this.year_charts = [];
      }

      LastfmCharts.prototype.reset_charts = function() {
        var i, idx, year, _i, _ref, _results;
        _results = [];
        for (i = _i = 0, _ref = this.year_charts.length; _i < _ref; i = _i += 1) {
          _results.push((function() {
            var _ref1, _results1;
            _ref1 = this.year_charts;
            _results1 = [];
            for (idx in _ref1) {
              year = _ref1[idx];
              _results1.push(this.year_charts.splice(idx, 1));
            }
            return _results1;
          }).call(this));
        }
        return _results;
      };

      LastfmCharts.prototype.get_chart_from_year_charts = function(from, to) {
        var chart, year_chart, _i, _j, _len, _len1, _ref, _ref1;
        _ref = this.year_charts;
        for (_i = 0, _len = _ref.length; _i < _len; _i++) {
          year_chart = _ref[_i];
          _ref1 = year_chart.charts;
          for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
            chart = _ref1[_j];
            if (chart.from === from && chart.to === to) {
              return chart;
            }
          }
        }
        return false;
      };

      LastfmCharts.prototype.get_chart = function(from, to) {
        var chart;
        chart = this.get_chart_from_year_charts(from, to);
        if (!chart) {
          chart = new LastfmChart({
            from: from,
            to: to
          });
        }
        return chart;
      };

      LastfmCharts.prototype.get_weekly_chart_list = function(user, callback) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var chart_data, week_chart, year, year_obj, _i, _len, _ref;
          if (data.weeklychartlist) {
            _ref = data.weeklychartlist.chart.slice(0).reverse();
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              chart_data = _ref[_i];
              week_chart = new LastfmChart(chart_data);
              year = week_chart.year();
              year_obj = _this.year_charts.filter(function(obj) {
                return obj.year === year;
              })[0];
              if (year_obj) {
                year_obj.charts.push(week_chart);
              } else {
                _this.year_charts.push({
                  year: year,
                  charts: [week_chart]
                });
              }
            }
          } else if (data.error) {
            Notification.error(data.message);
          }
          if (callback) {
            return callback();
          }
        };
        return $http({
          url: Lastfm.get_weekly_chart_list_url(user),
          method: 'GET'
        }).success(on_success).error(function(data, status, headers, config) {
          Notification.error(data);
          if (callback) {
            return callback();
          }
        });
      };

      LastfmCharts.prototype.get_weekly_track_chart = function(user, chart, callback) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var track_data, _i, _len, _ref;
          if (data.weeklytrackchart.track) {
            _ref = data.weeklytrackchart.track;
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              track_data = _ref[_i];
              chart.tracks.push(new LastfmTrack(track_data));
            }
          } else {
            chart.no_tracks = true;
          }
          if (callback) {
            return callback();
          }
        };
        return $http({
          url: Lastfm.get_weekly_track_chart_url(user, chart),
          method: 'GET'
        }).success(on_success).error(function(data, status, headers, config) {
          Notification.error(data);
          if (callback) {
            return callback();
          }
        });
      };

      return LastfmCharts;

    })();
    return new LastfmCharts();
  });

}).call(this);
