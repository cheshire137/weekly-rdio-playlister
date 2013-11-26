(function() {
  var __bind = function(fn, me){ return function(){ return fn.apply(me, arguments); }; };

  playlister_app.factory('LastfmCharts', function($http, Notification, Lastfm) {
    var LastfmCharts;
    LastfmCharts = (function() {
      function LastfmCharts() {
        this.on_error = __bind(this.on_error, this);
        this.year_charts = [];
        this.user = {};
        this.neighbors = [];
        this.load_status = {
          charts: false
        };
      }

      LastfmCharts.prototype.on_error = function(data, status, headers, config) {
        return Notification.error(data);
      };

      LastfmCharts.prototype.reset_charts = function() {
        var i, idx, key, neighbor, value, year, _i, _j, _ref, _ref1, _ref2, _ref3, _results;
        this.charts_loaded = false;
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

      LastfmCharts.prototype.get_user_neighbors = function(user_name) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var i, user_data, _i, _ref, _results;
          if (data.neighbours) {
            _results = [];
            for (i = _i = 0, _ref = Math.min(8, data.neighbours.user.length); _i < _ref; i = _i += 1) {
              user_data = data.neighbours.user[i];
              _results.push(_this.neighbors.push(new LastfmNeighbor(user_data)));
            }
            return _results;
          }
        };
        return $http.get(Lastfm.get_user_neighbors_url(user_name)).success(on_success).error(this.on_error);
      };

      LastfmCharts.prototype.get_user_info = function(user_name) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var key, value, _ref, _results;
          if (data.user) {
            _ref = new LastfmUser(data.user);
            _results = [];
            for (key in _ref) {
              value = _ref[key];
              _results.push(_this.user[key] = value);
            }
            return _results;
          }
        };
        return $http.get(Lastfm.get_user_info_url(user_name)).success(on_success).error(this.on_error);
      };

      LastfmCharts.prototype.get_charts_after_cutoff_date = function(charts_data, cutoff_date) {
        var charts;
        charts = charts_data.map(function(data) {
          return new LastfmChart(data);
        });
        return charts.filter(function(chart) {
          return chart.to_date() >= cutoff_date;
        });
      };

      LastfmCharts.prototype.initialize_year_charts = function(charts) {
        var week_chart, year, year_chart, _i, _len, _results;
        _results = [];
        for (_i = 0, _len = charts.length; _i < _len; _i++) {
          week_chart = charts[_i];
          year = week_chart.year();
          year_chart = this.year_charts.filter(function(obj) {
            return obj.year === year;
          })[0];
          if (year_chart) {
            _results.push(year_chart.charts.push(week_chart));
          } else {
            _results.push(this.year_charts.push({
              year: year,
              charts: [week_chart]
            }));
          }
        }
        return _results;
      };

      LastfmCharts.prototype.get_weekly_chart_list_after_date = function(user, cutoff_date) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var charts, charts_data;
          if (data.weeklychartlist) {
            charts_data = data.weeklychartlist.chart.slice(0).reverse();
            charts = _this.get_charts_after_cutoff_date(charts_data, cutoff_date);
            _this.initialize_year_charts(charts);
          } else if (data.error) {
            Notification.error(data.message);
          }
          return _this.load_status.charts = true;
        };
        return $http.get(Lastfm.get_weekly_chart_list_url(user)).success(on_success).error(function(data, status, headers, config) {
          Notification.error(data);
          return _this.load_status.charts = true;
        });
      };

      LastfmCharts.prototype.get_weekly_track_chart = function(user, chart) {
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
          return chart.loaded = true;
        };
        return $http.get(Lastfm.get_weekly_track_chart_url(user, chart)).success(on_success).error(this.on_error);
      };

      return LastfmCharts;

    })();
    return new LastfmCharts();
  });

}).call(this);
