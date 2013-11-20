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
      for (i = _i = 0, _ref = this.tracks.length; _i < _ref; i = _i += 4) {
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

    LastfmChart.prototype.same_year = function() {
      return this.from_date().getFullYear() === this.to_date().getFullYear();
    };

    LastfmChart.prototype.same_month = function() {
      var same_month;
      return same_month = this.from_date().getMonth() === this.to_date().getMonth();
    };

    LastfmChart.prototype.from_date_str = function() {
      if (this.same_year()) {
        return moment(this.from_date()).format('MMMM D');
      } else {
        return moment(this.from_date()).format('MMMM D, YYYY');
      }
    };

    LastfmChart.prototype.to_date_str = function() {
      if (this.same_year() && this.same_month()) {
        return moment(this.to_date()).format('D, YYYY');
      } else {
        return moment(this.to_date()).format('MMMM D, YYYY');
      }
    };

    LastfmChart.prototype.from_date_utc_str = function() {
      return this.from_date().toUTCString();
    };

    LastfmChart.prototype.to_date_utc_str = function() {
      return this.to_date().toUTCString();
    };

    LastfmChart.prototype.to_s = function() {
      if (this.same_year() && this.same_month()) {
        return "" + (this.from_date_str()) + "-" + (this.to_date_str());
      } else {
        return "" + (this.from_date_str()) + " to " + (this.to_date_str());
      }
    };

    return LastfmChart;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).LastfmChart = LastfmChart;

}).call(this);