(function() {
  var LastfmTrack;

  LastfmTrack = (function() {
    function LastfmTrack(data) {
      this.name = data.name;
      this.mbid = data.mbid;
      this.artist = data.artist['#text'];
      this.artist_mbid = data.artist.mbid;
      this.play_count = data.playcount;
      this.url = data.url;
      if (this.url.indexOf('http://') < 0) {
        this.url = 'http://' + this.url;
      }
      this.small_image = data.image.filter(function(i) {
        return i.size === 'small';
      })[0]['#text'];
      this.medium_image = data.image.filter(function(i) {
        return i.size === 'medium';
      })[0]['#text'];
      this.large_image = data.image.filter(function(i) {
        return i.size === 'large';
      })[0]['#text'];
    }

    return LastfmTrack;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).LastfmTrack = LastfmTrack;

}).call(this);
