'use strict'

describe 'route', ->
  describe '/login', ->
    it 'shows the Rdio login button', ->
      browser().navigateTo '/base/spec/test-index.html#/login'
      expect(element('a[href="/auth/rdio"]').count()).toBe 1

  describe '/', ->
    it 'has a Last.fm form', ->
      browser().navigateTo '/base/spec/test-index.html#/'
      expect(element('form[action="#/lastfm/"]').count()).toBe 1

  describe '/lastfm/:user', ->
    it 'has a list of weeks', ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/cheshire137'
      expect(element('.week-link').count()).toBe 1

  describe '/lastfm/:user/chart/:from/:to', ->
    it 'has a list of tracks', ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/cheshire137/chart/1381665600/1382270400'
      expect(element('.track').count()).toBe 2
