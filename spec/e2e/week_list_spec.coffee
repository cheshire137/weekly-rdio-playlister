'use strict'

describe 'week list', ->
  describe 'for valid Last.fm user', ->
    beforeEach ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/validuser'

    it 'has a list of weeks', ->
      expect(element('.week-link').count()).toBe 1

    it 'includes the Last.fm user name', ->
      expect(element('.lastfm-user').text()).toEqual 'validuser'

    it 'has nicely formatted date for week', ->
      expect(element('.week-link').text()).toContain 'October 13-20, 2013'

    it 'has a link to view tracks in week chart', ->
      url = '#/lastfm/validuser/chart/1381665600/1382270400'
      expect(element('a[href="' + url + '"]').count()).toBe 1

    it 'has a link back to the Last.fm user form', ->
      expect(element('a[href="#/"]').count()).toBeGreaterThan 0

    describe 'go back to Last.fm user form', ->
      beforeEach ->
        element('.page-header a[href="#/"]').click()

      describe 'choose a different Last.fm user', ->
        beforeEach ->
          input('lastfm.user').enter('otheruser')
          element('button[type="submit"]').click()

        it 'has a list of weeks', ->
          expect(element('.week-link').count()).toBe 1

        it "displays only the new user's week history", ->
          expect(element('.week-link').text()).toContain 'March 3-10, 2013'

  describe 'for invalid Last.fm user', ->
    beforeEach ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/baduser'

    it 'has an error saying no user found', ->
      message = 'No user with that name was found'
      expect(element('.notifications .alert-danger').text()).toContain message

    it 'includes the Last.fm user name', ->
      expect(element('.lastfm-user').text()).toEqual 'baduser'

    it 'does not have a list of weeks', ->
      expect(element('.week-link').count()).toBe 0

    it 'has a link back to the Last.fm user form', ->
      expect(element('a[href="#/"]').count()).toBeGreaterThan 0

    describe 'return to user form', ->
      it 'no longer has error message', ->
        element('.page-header a[href="#/"]').click()
        expect(element('.notifications .alert-danger').count()).toBe 0
