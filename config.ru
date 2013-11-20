root_path = File.join(Dir.pwd, 'public')
use Rack::Static, urls: ['/css', '/img', '/js'], root: root_path,
                  index: 'index.html'
run Rack::URLMap.new({'/' => Rack::Directory.new(root_path)})
