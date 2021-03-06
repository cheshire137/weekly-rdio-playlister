# Weekly Rdio Playlister

If you use Last.fm for scrobbling the music you listen to, you have access to
[weekly charts](http://www.last.fm/api/show/user.getWeeklyTrackChart) of tracks
that you listened to. I wanted a way to turn those charts into Rdio playlists
so I could look back and remember, through music, what kind of mood I was in,
what artists I had just discovered, and what I was into during a particular
time. "That was the winter of Blue Foundation", "I had just found SBTRKT", and
"Wow, lots of game soundtracks" come to mind.

## How to Run It Yourself

I built this using Ruby 2 in OS X.

1. `git clone git@github.com:cheshire137/weekly-rdio-playlister.git`
2. `cd weekly-rdio-playlister`
3. `bundle` to install necessary gems.
4. [Register for an Rdio API account](https://secure.mashery.com/login/rdio.mashery.com/).
5. `cp env.sh.sample env.sh`
6. Modify env.sh and fill in your Rdio API key and secret.
7. `source env.sh`
8. `foreman start` to start the server at `http://localhost:3000` and run Guard so that Haml, CoffeeScript, and LESS get compiled into HTML, JavaScript,
and CSS.

## How to Test

1. `npm install`
2. `npm test`

## License

The source code is released under the GNU GPL v3.

## Screenshots

![Screenshot of Weekly Rdio Playlister](https://raw.githubusercontent.com/cheshire137/weekly-rdio-playlister/master/screenshot.png)

![Screenshot of Weekly Rdio Playlister](https://raw.githubusercontent.com/cheshire137/weekly-rdio-playlister/master/screenshot1.png)

![Screenshot of Weekly Rdio Playlister](https://raw.githubusercontent.com/cheshire137/weekly-rdio-playlister/master/screenshot2.png)

![Screenshot of Weekly Rdio Playlister](https://raw.githubusercontent.com/cheshire137/weekly-rdio-playlister/master/screenshot3.png)

![Screenshot of Weekly Rdio Playlister](https://raw.githubusercontent.com/cheshire137/weekly-rdio-playlister/master/screenshot4.png)
