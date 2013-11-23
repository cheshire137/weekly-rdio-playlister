'use strict'

describe 'Last.fm form', ->
  beforeEach ->
    browser().navigateTo '/base/spec/test-index.html#/'

  it 'has a form', ->
    browser().navigateTo '/base/spec/test-index.html#/'
    expect(element('form').count()).toBe 1

  it 'takes you to weeks list upon submission', ->
    input('lastfm.user').enter('cheshire137')
    element('button[type="submit"]').click()
    expect(browser().location().url()).toBe "/lastfm/cheshire137"
