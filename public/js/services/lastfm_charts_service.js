(function() {
  playlister_app.factory('LastfmCharts', function($http, Notification, Lastfm) {
    var LastfmCharts;
    LastfmCharts = (function() {
      function LastfmCharts() {
        this.year_charts = [];
        this.user = {};
        this.neighbors = [];
      }

      LastfmCharts.prototype.reset_charts = function() {
        var i, idx, key, neighbor, value, year, _i, _j, _ref, _ref1, _ref2, _ref3, _results;
        _ref = this.user;
        for (key in _ref) {
          value = _ref[key];
          delete this.user[key];
        }
        for (i = _i = 0, _ref1 = this.year_charts.length; _i < _ref1; i = _i += 1) {
          _ref2 = this.year_charts;
          for (idx in _ref2) {
            year = _ref2[idx];
            this.year_charts.splice(idx, 1);
          }
        }
        _results = [];
        for (i = _j = 0, _ref3 = this.neighbors.length; _j < _ref3; i = _j += 1) {
          _results.push((function() {
            var _ref4, _results1;
            _ref4 = this.neighbors;
            _results1 = [];
            for (idx in _ref4) {
              neighbor = _ref4[idx];
              _results1.push(this.neighbors.splice(idx, 1));
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

      LastfmCharts.prototype.get_user_neighbors = function(user_name, callback) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var i, user_data, _i, _ref;
          if (data.neighbours) {
            for (i = _i = 0, _ref = Math.min(8, data.neighbours.user.length); _i < _ref; i = _i += 1) {
              user_data = data.neighbours.user[i];
              _this.neighbors.push(new LastfmNeighbor(user_data));
            }
          }
          if (callback) {
            return callback();
          }
        };
        return $http({
          url: Lastfm.get_user_neighbors_url(user_name),
          method: 'GET'
        }).success(on_success).error(function(data, status, headers, config) {
          Notification.error(data);
          if (callback) {
            return callback();
          }
        });
      };

      LastfmCharts.prototype.get_user_info = function(user_name, callback) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var key, value, _ref;
          if (data.user) {
            _ref = new LastfmUser(data.user);
            for (key in _ref) {
              value = _ref[key];
              _this.user[key] = value;
            }
          }
          if (callback) {
            return callback();
          }
        };
        return $http({
          url: Lastfm.get_user_info_url(user_name),
          method: 'GET'
        }).success(on_success).error(function(data, status, headers, config) {
          Notification.error(data);
          if (callback) {
            return callback();
          }
        });
      };

      LastfmCharts.prototype.get_weekly_chart_list_after_date = function(user, cutoff_date, callback) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var chart_data, week_chart, year, year_obj, _i, _len, _ref;
          if (data.weeklychartlist) {
            _ref = data.weeklychartlist.chart.slice(0).reverse();
            for (_i = 0, _len = _ref.length; _i < _len; _i++) {
              chart_data = _ref[_i];
              week_chart = new LastfmChart(chart_data);
              if (week_chart.to_date() >= cutoff_date) {
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

      LastfmCharts.prototype.get_weekly_chart_list = function(user_name, callback) {
        var _this = this;
        return this.get_user_info(user_name, function() {
          return _this.get_weekly_chart_list_after_date(user_name, _this.user.date_registered, callback);
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
