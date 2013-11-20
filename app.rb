require 'sinatra'
require 'omniauth'
require 'omniauth-rdio'
require 'json'
require './user.rb'
require 'rdio'

RDIO_API_KEY = ENV['RDIO_API_KEY']
RDIO_API_SHARED_SECRET = ENV['RDIO_API_SHARED_SECRET']

enable :sessions

use OmniAuth::Builder do
  provider :rdio, RDIO_API_KEY, RDIO_API_SHARED_SECRET
end

def get_client session
  client = Rdio::Client.new(RDIO_API_KEY, RDIO_API_SHARED_SECRET)
  if session[:access_token] && session[:access_secret]
    client.access_token = session[:access_token]
    client.secret = session[:access_secret]
  end
  puts 'Client:'
  puts client.inspect
  client
end

set :public_dir, File.dirname(__FILE__) + '/public'

get '/' do
  if session[:user]
    redirect '/index.html?authenticated=1'
  else
    redirect '/index.html'
  end
end

get '/auth/:name/callback' do
  # See https://github.com/nixme/omniauth-rdio for description of object
  auth = request.env['omniauth.auth']
  access_token = auth['credentials']['token']
  access_secret = auth['credentials']['secret']
  session[:user] = User.new(auth)
  session[:access_token] = access_token
  session[:access_secret] = access_secret
  redirect '/index.html?user=' + session[:user].to_json
end

get '/rdio_artist_search' do
  content_type :json
  client = get_client(session)
  query = params[:query]
  response = client.search(query, 'Artist')
  puts response.inspect
  if response.count > 0
    artist = response[0]
    artist_id = artist.key
    name = artist.name
    {artist_id: artist_id, name: name}.to_json
  else
    {artist_id: nil, error: "Could not find artist '#{query}'"}.to_json
  end
end

get '/rdio_track_search' do
  content_type :json
  client = get_client(session)
  query = params[:query]
  artist_id = params[:artist_id]
  response = client.getTracksForArtist(artist: artist_id, query: query)
  puts response.inspect
  if response.count > 0
    track_id = response[0].key
    {track_id: track_id}.to_json
  else
    {track_id: nil, error: "Could not find track '#{query}'"}.to_json
  end
end

post '/rdio_playlist_create' do
  content_type :json
  json_params = JSON.parse(request.body.read)
  name = json_params['name']
  description = json_params['description']
  tracks = json_params['tracks']
  client = get_client(session)
  response = client.createPlaylist(name: name, description: description,
                                   tracks: tracks)
  {name: response.name, song_count: response.length, image_url: response.icon,
   embed_url: response.embedUrl, key: response.key}.to_json
end
