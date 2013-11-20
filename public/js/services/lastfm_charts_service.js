(function() {
  playlister_app.factory('LastfmCharts', function($http, Lastfm) {
    var LastfmCharts;
    LastfmCharts = (function() {
      function LastfmCharts() {
        this.weeks = [];
      }

      LastfmCharts.prototype.get_weekly_chart_list = function(user, on_error) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var chart_data, _i, _len, _ref, _results;
          _ref = data.weeklychartlist.chart;
          _results = [];
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            chart_data = _ref[_i];
            _results.push(_this.weeks.push(new LastfmChart(chart_data)));
          }
          return _results;
        };
        return $http({
          url: Lastfm.get_weekly_chart_list_url(user),
          method: 'GET'
        }).success(on_success).error(on_error);
      };

      LastfmCharts.prototype.get_weekly_track_chart = function(user, chart, on_error) {
        var on_success,
          _this = this;
        on_success = function(data, status, headers, config) {
          var track_data, _i, _len, _ref;
          console.log(data);
          _ref = data.weeklytrackchart.track;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            track_data = _ref[_i];
            chart.tracks.push(new LastfmTrack(track_data));
          }
          return console.log(chart.tracks);
        };
        return $http({
          url: Lastfm.get_weekly_track_chart_url(user, chart),
          method: 'GET'
        }).success(on_success).error(on_error);
      };

      return LastfmCharts;

    })();
    return new LastfmCharts();
  });

}).call(this);
