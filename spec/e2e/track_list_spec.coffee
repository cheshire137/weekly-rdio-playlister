'use strict'

describe 'track list', ->
  beforeEach ->
    browser().navigateTo '/base/spec/test-index.html#/lastfm/cheshire137/chart/1381665600/1382270400'

  it 'has a list of tracks', ->
    expect(element('.track').count()).toBe 2
