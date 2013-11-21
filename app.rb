# encoding=utf-8
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
  client
end

def strip_smart_quotes str
  str.gsub(/[‘’]/, "'").gsub(/[”“]/, '"')
end

root_path = File.join(Dir.pwd, 'public')
set :public_dir, root_path
use Rack::Static, urls: ['/css', '/img', '/js'], root: root_path,
                  index: 'index.html'

get '/' do
  if session[:user]
    redirect '/index.html'
  else
    redirect '/index.html/#/login'
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
  redirect '/index.html'
end

get '/rdio_artist_search' do
  content_type :json
  client = get_client(session)
  query = strip_smart_quotes(params[:query])
  artists = client.search(query, 'Artist')
  if artists.count > 0
    artist = artists[0]
    puts artist.inspect
    {id: artist.key, name: artist.name}.to_json
  else
    {id: nil, error: "Could not find artist '#{query}' on Rdio."}.to_json
  end
end

get '/rdio_track_search' do
  content_type :json
  client = get_client(session)
  query = strip_smart_quotes(params[:query])
  artist_id = params[:artist_id]
  tracks = client.getTracksForArtist(artist: artist_id, query: query)
  if tracks.count > 0
    track = tracks[0]
    puts track.inspect
    {id: track.key}.to_json
  else
    {id: nil, error: "Could not find track '#{query}' on Rdio."}.to_json
  end
end

post '/rdio_playlist_create' do
  content_type :json
  json_params = JSON.parse(request.body.read)
  name = json_params['name']
  description = json_params['description']
  tracks = json_params['tracks']
  client = get_client(session)
  playlist = client.createPlaylist(name: name, description: description,
                                   tracks: tracks)
  puts playlist.inspect
  {name: playlist.name, song_count: playlist.length, image_url: playlist.icon,
   id: playlist.key, url: playlist.shortUrl}.to_json
end
