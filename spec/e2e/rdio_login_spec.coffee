'use strict'

describe 'Rdio login', ->
  beforeEach ->
    browser().navigateTo '/base/spec/test-index.html#/login'

  it 'shows the Rdio login button', ->
    browser().navigateTo '/base/spec/test-index.html#/login'
    expect(element('a[href="/auth/rdio"]').count()).toBe 1
