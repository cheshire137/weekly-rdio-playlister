(function() {
  var LastfmChart;

  LastfmChart = (function() {
    function LastfmChart(data) {
      this.from = data.from;
      this.to = data.to;
    }

    LastfmChart.prototype.from_date = function() {
      return new Date(1000 * this.from);
    };

    LastfmChart.prototype.to_date = function() {
      return new Date(1000 * this.to);
    };

    LastfmChart.prototype.from_date_str = function() {
      return this.from_date().toUTCString();
    };

    LastfmChart.prototype.to_date_str = function() {
      return this.to_date().toUTCString();
    };

    LastfmChart.prototype.to_s = function() {
      return "" + (this.from_date_str()) + " to " + (this.to_date_str());
    };

    return LastfmChart;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).LastfmChart = LastfmChart;

}).call(this);
