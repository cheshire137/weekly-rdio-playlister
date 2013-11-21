class LastfmTrack
  constructor: (data) ->
    @name = data.name
    @mbid = data.mbid
    @artist = data.artist['#text']
    @artist_mbid = data.artist.mbid
    @play_count = data.playcount
    @url = data.url
    if @url.indexOf('http://') < 0
      @url = 'http://' + @url
    @small_image = data.image.filter((i) -> i.size == 'small')[0]['#text']
    @medium_image = data.image.filter((i) -> i.size == 'medium')[0]['#text']
    @large_image = data.image.filter((i) -> i.size == 'large')[0]['#text']
    unless @large_image
      @large_image = '/img/missing-track-image.png'

(exports ? this).LastfmTrack = LastfmTrack
