(function() {
  var LastfmUser;

  LastfmUser = (function() {
    function LastfmUser(data) {
      this.user_name = data.name;
      this.real_name = data.realname;
      if (this.real_name.trim() === '') {
        this.real_name = void 0;
      }
      this.url = data.url;
      this.id = data.id;
      this.country = data.country;
      this.age = data.age;
      this.gender = data.gender;
      this.play_count = parseInt(data.playcount, 10);
      this.date_registered = new Date(1000 * data.registered.unixtime);
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

    LastfmUser.prototype.date_registered_str = function() {
      return moment(this.date_registered).format('MMMM D, YYYY');
    };

    return LastfmUser;

  })();

  (typeof exports !== "undefined" && exports !== null ? exports : this).LastfmUser = LastfmUser;

}).call(this);
