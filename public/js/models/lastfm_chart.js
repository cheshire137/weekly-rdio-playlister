(function() {
  var LastfmChart;

  LastfmChart = (function() {
    function LastfmChart(data) {
      this.from = data.from;
      this.to = data.to;
      this.tracks = [];
    }

    LastfmChart.prototype.track_range = function() {
      var i, range, _i, _ref;
      range = [];
      for (i = _i = 0, _ref = this.tracks.length; _i < _ref; i = _i += 3) {
        range.push(i);
      }
      return range;
    };

    LastfmChart.prototype.from_date = function() {
      return new Date(1000 * this.from);
    };

    LastfmChart.prototype.to_date = function() {
      return new Date(1000 * this.to);
    };

    LastfmChart.prototype.from_date_str = function() {
      return moment(this.from_date()).format('MMMM D, YYYY');
    };

    LastfmChart.prototype.to_date_str = function() {
      return moment(this.to_date()).format('MMMM D, YYYY');
    };

    LastfmChart.prototype.from_date_utc_str = function() {
      return this.from_date().toUTCString();
    };

    LastfmChart.prototype.to_date_utc_str = function() {
      return this.to_date().toUTCString();
    };

    LastfmChart.prototype.to_s = function() {
      return "" + (this.from_date_str()) + " to " + (this.to_date_str());
    };

    return LastfmChart;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).LastfmChart = LastfmChart;

}).call(this);
