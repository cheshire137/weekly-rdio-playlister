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

  to_s: ->
    if @same_year() && @same_month()
      "#{@from_date_str()}-#{@to_date_str()}"
    else
      "#{@from_date_str()} to #{@to_date_str()}"

(exports ? this).LastfmChart = LastfmChart
