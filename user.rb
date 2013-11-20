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
