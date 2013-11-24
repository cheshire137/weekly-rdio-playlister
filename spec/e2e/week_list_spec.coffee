'use strict'

describe 'week list', ->
  describe 'for valid Last.fm user', ->
    beforeEach ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/validuser'

    it 'has two weeks', ->
      expect(element('.week-link').count()).toBe 2

    it 'includes the Last.fm real name', ->
      expect(element('.lastfm-user').text()).toContain 'Valid User'

    it 'has nicely formatted dates for weeks', ->
      expect(element('.week-link').text()).toContain 'October 13-20, 2013'
      expect(element('.week-link').text()).toContain 'December 26, 2010 ' +
                                                     'to January 2, 2011'

    it 'has a year filter', ->
      expect(element('#chart_filters_year_chart').count()).toBe 1

    it 'has links to view tracks in each week chart', ->
      url = '#/lastfm/validuser/chart/1381665600/1382270400'
      expect(element('a[href="' + url + '"]').count()).toBe 1
      url = '#/lastfm/validuser/chart/1293364800/1293969600'
      expect(element('a[href="' + url + '"]').count()).toBe 1

    it 'has a link back to the Last.fm user form', ->
      expect(element('a[href="#/"]').count()).toBeGreaterThan 0

    describe 'filter by year', ->
      beforeEach ->
        select('chart_filters.year_chart').option(2010)

      it 'shows weeks in selected year', ->
        expect(element('.chart-weeks .year-2010').count()).toBe 1

      it 'hides weeks not in selected year', ->
        expect(element('.chart-weeks .year-2013').count()).toBe 0

      it 'has link to view tracks in week in the selected year', ->
        url = '#/lastfm/validuser/chart/1293364800/1293969600'
        expect(element('.chart-weeks a[href="' + url + '"]').count()).toBe 1

      it 'does not have link for week in year that is not selected', ->
        url = '#/lastfm/validuser/chart/1381665600/1382270400'
        expect(element('.chart-weeks a[href="' + url + '"]').count()).toBe 0

    describe 'go back to Last.fm user form', ->
      beforeEach ->
        element('.page-header a[href="#/"]').click()

      describe 'choose a different Last.fm user', ->
        beforeEach ->
          input('lastfm_user.user_name').enter('otheruser')
          element('button[type="submit"]').click()

        it 'has only one week', ->
          expect(element('.week-link').count()).toBe 1

        it "displays the new user's week history", ->
          expect(element('.week-link').text()).toContain 'March 3-10, 2013'

  describe 'for invalid Last.fm user', ->
    beforeEach ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/baduser'

    it 'has an error saying no user found', ->
      message = 'No user with that name was found'
      expect(element('.notifications .alert-danger').text()).toContain message

    it 'includes the Last.fm user name', ->
      expect(element('.lastfm-user').text()).toContain 'baduser'

    it 'does not have a list of weeks', ->
      expect(element('.week-link').count()).toBe 0

    it 'has a link back to the Last.fm user form', ->
      expect(element('a[href="#/"]').count()).toBeGreaterThan 0

    it 'has no year filter', ->
      expect(element('#chart_filters_year_chart').count()).toBe 0

    describe 'return to user form', ->
      it 'no longer has error message', ->
        element('.page-header a[href="#/"]').click()
        expect(element('.notifications .alert-danger').count()).toBe 0
