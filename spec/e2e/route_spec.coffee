'use strict'

describe 'route', ->
  describe '/login', ->
    it 'exists', ->
      browser().navigateTo '/base/spec/test-index.html#/login'
      expect(browser().location().url()).toBe "/login"

  describe '/', ->
    it 'exists', ->
      browser().navigateTo '/base/spec/test-index.html#/'
      expect(browser().location().url()).toBe "/"

  describe '/lastfm/:user', ->
    it 'exists', ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/cheshire137'
      expect(browser().location().url()).toBe "/lastfm/cheshire137"

  describe '/lastfm/:user/chart/:from/:to', ->
    it 'exists', ->
      path = '/lastfm/cheshire137/chart/1381665600/1382270400'
      browser().navigateTo "/base/spec/test-index.html##{path}"
      expect(browser().location().url()).toBe path
