'use strict'

describe 'week list', ->
  beforeEach ->
    browser().navigateTo '/base/spec/test-index.html#/lastfm/cheshire137'

  it 'has a list of weeks', ->
    expect(element('.week-link').count()).toBe 1

  it 'includes the Last.fm user name', ->
    expect(element('.lastfm-user').text()).toEqual 'cheshire137'

  it 'has nicely formatted date for week', ->
    expect(element('.week-link').text()).toContain 'October 13-20, 2013'

  it 'has a link to view tracks in week chart', ->
    url = '#/lastfm/cheshire137/chart/1381665600/1382270400'
    expect(element('a[href="' + url + '"]').count()).toBe 1

  it 'has a link back to the Last.fm user form', ->
    expect(element('a[href="#/"]').count()).toBe 1
