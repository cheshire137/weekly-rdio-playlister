require 'sinatra'
require 'rdio_api'
require 'oauth/consumer'
require 'json'

OAuth::VERSION = 1

RDIO_API_KEY = ENV['RDIO_API_KEY']
RDIO_API_SHARED_SECRET = ENV['RDIO_API_SHARED_SECRET']
DOMAIN = ENV['DOMAIN']
SITE = 'http://api.rdio.com'
PATH = '/1/'

puts "Initializing Rdio consumer"
consumer = OAuth::Consumer.new(RDIO_API_KEY, RDIO_API_SHARED_SECRET,
                               {site: SITE})
consumer.http.read_timeout = 600
puts "Initializing Rdio access token"
access_token = OAuth::AccessToken.new(consumer)
puts "Rdio API ready"
client = RdioApi.new(consumer_key: RDIO_API_KEY,
                     consumer_secret: RDIO_API_SHARED_SECRET,
                     access_token: access_token)

set :public_dir, File.dirname(__FILE__) + '/public'

get '/' do
  redirect '/index.html'
end

get '/rdio_track_search' do
  content_type :json
  response = client.search(query: params[:query], types: 'Track')
  if response.results.size > 0
    track_id = response.results[0]['key']
    {track_id: track_id}.to_json
  else
    {track_id: nil, error: 'Track not found'}.to_json
  end
end

post '/rdio_playlist_create' do
  json_params = JSON.parse(request.body.read)
  name = json_params['name']
  description = json_params['description']
  tracks = json_params['tracks']
  puts "Playlist name: #{name}"
  puts "Playlist description: #{description}"
  puts "Playlist tracks: #{tracks}"
  response = client.createPlaylist(name: name, description: description,
                                   tracks: tracks)
  puts response.inspect
  redirect '/index.html'
end
