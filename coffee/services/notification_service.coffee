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

playlister_app.factory 'Notification', ->
  class Notification
    constructor: ->
      @notices = []
      @errors = []

    remove: (type, id) ->
      if type == 'error'
        @errors.splice(idx, 1) for idx, error of @errors when error.id == id
      else
        @notices.splice(idx, 1) for idx, notice of @notices when notice.id == id

    error: (message) ->
      return unless message
      console.error message
      id = @errors.length + 1
      @errors.push
        message: message
        id: id

    notice: (message) ->
      return unless message
      id = @notices.length + 1
      @notices.push
        message: message
        id: id

  new Notification()
