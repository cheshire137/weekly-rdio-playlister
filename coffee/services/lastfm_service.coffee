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

playlister_app.factory 'Lastfm', (PlaylisterConfig) ->
  class Lastfm
    constructor: ->
      @api_url = 'http://ws.audioscrobbler.com/2.0/'

    get_api_url: (method, params) ->
      url = @api_url + '?method=' + method
      url += '&api_key=' + PlaylisterConfig.lastfm_api_key + '&format=json'
      for key, value of params
        url += "&#{key}=#{encodeURIComponent(value)}"
      url

    get_user_info_url: (user) ->
      @get_api_url 'user.getinfo',
        user: user

    get_weekly_chart_list_url: (user) ->
      @get_api_url 'user.getweeklychartlist',
        user: user

    get_weekly_track_chart_url: (user, chart) ->
      @get_api_url 'user.getweeklytrackchart',
        user: user
        from: chart.from
        to: chart.to

  new Lastfm()
