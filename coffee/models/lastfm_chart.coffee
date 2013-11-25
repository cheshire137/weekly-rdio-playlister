# Copyright 2013 Sarah Vessels
#
# This program is free software: you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation, either version 3 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.

class LastfmChart
  constructor: (data) ->
    @from = data.from
    @to = data.to
    @tracks = []

  track_count: ->
    @tracks.length

  from_date: ->
    new Date(1000 * @from)

  to_date: ->
    new Date(1000 * @to)

  playlist_name: (min_play_count) ->
    if @tracks.length < 1
      return @to_s()
    @top_artists_str(min_play_count) + ' - ' + @month_range_str()

  # Returns a comma-separated string of the top 3 artists in this chart.
  top_artists_str: (min_play_count) ->
    artist_counts = {}
    for track in @tracks when track.play_count >= min_play_count
      artist = track.artist
      if artist_counts.hasOwnProperty(artist)
        artist_counts[artist] += track.play_count
      else
        artist_counts[artist] = track.play_count
    tuples = ([artist, count] for artist, count of artist_counts)
    tuples.sort (a, b) ->
      if a[1] < b[1] then 1 else if a[1] > b[1] then -1 else 0
    limit = Math.min(3, tuples.length)
    top_artist_counts = tuples.slice(0, limit)
    (artist_count[0] for artist_count in top_artist_counts).join(', ')

  year: ->
    parseInt(moment(@from_date()).format('YYYY'), 10)

  same_year: ->
    @from_date().getFullYear() == @to_date().getFullYear()

  same_month: ->
    same_month = @from_date().getMonth() == @to_date().getMonth()

  from_date_str: ->
    if @same_year()
      moment(@from_date()).format('MMMM D')
    else
      moment(@from_date()).format('MMMM D, YYYY')

  to_date_str: ->
    if @same_year() && @same_month()
      moment(@to_date()).format('D, YYYY')
    else
      moment(@to_date()).format('MMMM D, YYYY')

  from_date_utc_str: ->
    @from_date().toUTCString()

  to_date_utc_str: ->
    @to_date().toUTCString()

  month_range_str: ->
    if @same_year() && @same_month()
      moment(@from_date()).format('MMM YYYY')
    else
      moment(@from_date()).format('MMM') + '-' +
          moment(@to_date()).format('MMM YYYY')

  to_s: ->
    if @same_year() && @same_month()
      "#{@from_date_str()}-#{@to_date_str()}"
    else
      "#{@from_date_str()} to #{@to_date_str()}"

(exports ? this).LastfmChart = LastfmChart
