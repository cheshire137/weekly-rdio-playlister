# Weekly Rdio Playlister

If you use Last.fm for scrobbling the music you listen to, you have access to
[weekly charts](http://www.last.fm/api/show/user.getWeeklyTrackChart) of tracks
that you listened to. I wanted a way to turn those charts into Rdio playlists
so I could look back and remember, through music, what kind of mood I was in,
what artists I had just discovered, and what I was into during a particular
time. "That was the winter of Blue Foundation", "I had just found SBTRKT", and
"Wow, lots of game soundtracks" come to mind.

## Try It Out

**[Try Weekly Rdio Playlister on Heroku](http://weekly-rdio-playlister.herokuapp.com/)**

## How to Run It Yourself

I built this using Ruby 2 in OS X.

1. `git clone git@github.com:moneypenny/weekly-rdio-playlister.git`
2. `cd weekly-rdio-playlister`
3. `bundle` to install necessary gems.
4. [Register for an Rdio API account](https://secure.mashery.com/login/rdio.mashery.com/).
5. `cp env.sh.sample env.sh`
6. Modify env.sh and fill in your Rdio API key and secret.
7. `source env.sh`
8. `thin start` to start the server at `http://localhost:3000`.

If you change any files, be sure to run `bundle exec guard` so that Haml,
CoffeeScript, and LESS get compiled into HTML, JavaScript, and CSS.

## License

The source code is released under the GNU GPL v3.

## Screenshots

![Screenshot of Weekly Rdio Playlister Last.fm login](http://github.com/moneypenny/weekly-rdio-playlister/raw/master/screenshot1.png)

![Screenshot of Weekly Rdio Playlister After playlist creation](http://github.com/moneypenny/weekly-rdio-playlister/raw/master/screenshot.png)
