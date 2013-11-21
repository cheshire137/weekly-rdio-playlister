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

class User
  attr_reader :full_name, :playlists_url, :image_url

  def initialize oauth_data
    @full_name = oauth_data['info']['name']
    @playlists_url = oauth_data['info']['urls']['Playlists']
    @image_url = oauth_data['info']['image']
  end

  def to_json
    {full_name: @full_name, playlists_url: @playlists_url,
     image_url: @image_url}.to_json
  end

  def to_s
    @full_name
  end
end
