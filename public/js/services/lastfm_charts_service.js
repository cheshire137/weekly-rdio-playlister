(function() {
  playlister_app.factory('LastfmCharts', function($http, Lastfm) {
    var LastfmCharts;
    LastfmCharts = (function() {
      function LastfmCharts() {
        this.weeks = [];
      }

      LastfmCharts.prototype.update = function(user, on_error) {
        var on_success,
          _this = this;
        console.log('getting weeks...');
        on_success = function(data, status, headers, config) {
          var chart_data, _i, _len, _ref;
          console.log(data.weeklychartlist.chart);
          _ref = data.weeklychartlist.chart;
          for (_i = 0, _len = _ref.length; _i < _len; _i++) {
            chart_data = _ref[_i];
            _this.weeks.push(new LastfmChart(chart_data));
          }
          return console.log(_this.weeks);
        };
        return $http({
          url: Lastfm.get_weekly_chart_list_url(user),
          method: 'GET'
        }).success(on_success).error(on_error);
      };

      return LastfmCharts;

    })();
    return new LastfmCharts();
  });

}).call(this);
