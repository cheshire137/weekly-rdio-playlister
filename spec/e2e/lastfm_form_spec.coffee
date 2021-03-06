'use strict'

describe 'Last.fm form', ->
  beforeEach ->
    browser().navigateTo '/base/spec/test-index.html#/'

  it 'has a form', ->
    browser().navigateTo '/base/spec/test-index.html#/'
    expect(element('form').count()).toBe 1

  it 'takes you to weeks list upon submission', ->
    input('lastfm_user.user_name').enter('validuser')
    element('button[type="submit"]').click()
    expect(browser().location().url()).toBe "/lastfm/validuser"
