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

class LastfmNeighbor
  constructor: (data) ->
    @user_name = data.name
    @real_name = data.realname
    if @real_name && @real_name.trim() == ''
      @real_name = undefined
    @url = data.url
    @match_pct = parseFloat(data.match) * 100
    @small_image = data.image.filter((i) -> i.size == 'small')[0]['#text']
    @medium_image = data.image.filter((i) -> i.size == 'medium')[0]['#text']
    @large_image = data.image.filter((i) -> i.size == 'large')[0]['#text']
    @extra_large_image = data.image.filter((i) ->
      i.size == 'extralarge'
    )[0]['#text']

(exports ? this).LastfmNeighbor = LastfmNeighbor
