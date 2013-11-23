'use strict'

describe 'track list', ->
  describe 'week with tracks', ->
    beforeEach ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/validuser/chart/1381665600/1382270400'

    it 'has a list of tracks', ->
      expect(element('.track').count()).toBe 2

  describe 'week without tracks', ->
    beforeEach ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/validuser/chart/1383480000/1384084800'

    it 'has no tracks', ->
      expect(element('.track').count()).toBe 0

    it 'has message about no listening history', ->
      message = 'There is no listening history for Last.fm user'
      expect(element('.no-tracks-message').text()).toContain message

    it 'has message containing Last.fm user name', ->
      expect(element('.no-tracks-message').text()).toContain 'validuser'

    it 'has message containing week description', ->
      week = 'during November 3-10, 2013.'
      expect(element('.no-tracks-message').text()).toContain week
