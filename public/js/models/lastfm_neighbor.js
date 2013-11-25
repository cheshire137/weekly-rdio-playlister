(function() {
  var LastfmNeighbor;

  LastfmNeighbor = (function() {
    function LastfmNeighbor(data) {
      this.user_name = data.name;
      this.real_name = data.realname;
      if (this.real_name && this.real_name.trim() === '') {
        this.real_name = void 0;
      }
      this.url = data.url;
      this.match_pct = parseFloat(data.match) * 100;
      this.small_image = data.image.filter(function(i) {
        return i.size === 'small';
      })[0]['#text'];
      this.medium_image = data.image.filter(function(i) {
        return i.size === 'medium';
      })[0]['#text'];
      this.large_image = data.image.filter(function(i) {
        return i.size === 'large';
      })[0]['#text'];
      this.extra_large_image = data.image.filter(function(i) {
        return i.size === 'extralarge';
      })[0]['#text'];
    }

    return LastfmNeighbor;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).LastfmNeighbor = LastfmNeighbor;

}).call(this);
