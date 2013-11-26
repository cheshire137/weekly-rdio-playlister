(function() {
  var LastfmChart;

  LastfmChart = (function() {
    function LastfmChart(data) {
      this.from = data.from;
      this.to = data.to;
      this.tracks = [];
      this.loaded = false;
    }

    LastfmChart.prototype.track_count = function() {
      return this.tracks.length;
    };

    LastfmChart.prototype.from_date = function() {
      return new Date(1000 * this.from);
    };

    LastfmChart.prototype.to_date = function() {
      return new Date(1000 * this.to);
    };

    LastfmChart.prototype.playlist_name = function(min_play_count) {
      if (this.tracks.length < 1) {
        return this.to_s();
      }
      return this.top_artists_str(min_play_count) + ' - ' + this.month_range_str();
    };

    LastfmChart.prototype.top_artists_str = function(min_play_count) {
      var artist, artist_count, artist_counts, count, limit, top_artist_counts, track, tuples, _i, _len, _ref;
      artist_counts = {};
      _ref = this.tracks;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        track = _ref[_i];
        if (!(track.play_count >= min_play_count)) {
          continue;
        }
        artist = track.artist;
        if (artist_counts.hasOwnProperty(artist)) {
          artist_counts[artist] += track.play_count;
        } else {
          artist_counts[artist] = track.play_count;
        }
      }
      tuples = (function() {
        var _results;
        _results = [];
        for (artist in artist_counts) {
          count = artist_counts[artist];
          _results.push([artist, count]);
        }
        return _results;
      })();
      tuples.sort(function(a, b) {
        if (a[1] < b[1]) {
          return 1;
        } else if (a[1] > b[1]) {
          return -1;
        } else {
          return 0;
        }
      });
      limit = Math.min(3, tuples.length);
      top_artist_counts = tuples.slice(0, limit);
      return ((function() {
        var _j, _len1, _results;
        _results = [];
        for (_j = 0, _len1 = top_artist_counts.length; _j < _len1; _j++) {
          artist_count = top_artist_counts[_j];
          _results.push(artist_count[0]);
        }
        return _results;
      })()).join(', ');
    };

    LastfmChart.prototype.year = function() {
      return parseInt(moment(this.from_date()).format('YYYY'), 10);
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

    LastfmChart.prototype.month_range_str = function() {
      if (this.same_year() && this.same_month()) {
        return moment(this.from_date()).format('MMM YYYY');
      } else {
        return moment(this.from_date()).format('MMM') + '-' + moment(this.to_date()).format('MMM YYYY');
      }
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
