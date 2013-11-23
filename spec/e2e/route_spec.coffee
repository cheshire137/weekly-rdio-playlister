'use strict'

describe 'route', ->
  describe '/login', ->
    it 'shows the Rdio login button', ->
      browser().navigateTo '/base/spec/test-index.html#/login'
      expect(element('a[href="/auth/rdio"]').count()).toBe 1
