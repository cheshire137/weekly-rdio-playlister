'use strict'

describe 'track list', ->
  describe 'week with tracks', ->
    beforeEach ->
      browser().navigateTo '/base/spec/test-index.html#/lastfm/validuser/chart/1381665600/1382270400'

    it 'has a list of tracks', ->
      expect(element('.track').count()).toBe 2

    it 'has count of filtered tracks out of total tracks', ->
      expect(element('.subtitle').text()).toContain "Showing 2 of 2\n"

    it 'has plural tracks count', ->
      expect(element('.subtitle').text()).toContain "tracks\n"

    describe 'filter tracks by play count', ->
      beforeEach ->
        input('track_filters.min_play_count').enter('4')

      it 'changes how many tracks are displayed', ->
        expect(element('.track').count()).toBe 1

      it 'displays the track with a high enough play count', ->
        included_track_mbid = 'b6695955-aefd-4bcb-8ff4-d193bcfeee88'
        expect(element("##{included_track_mbid}").count()).toBe 1

      it 'does not display the track with a low play count', ->
        excluded_track_mbid = '07436946-4d54-46f7-a2f6-165df3b7348c'
        expect(element("##{excluded_track_mbid}").count()).toBe 0

      it 'updates filtered track count', ->
        expect(element('.subtitle').text()).toContain "Showing 1 of 2\n"

      it 'has singular tracks count', ->
        expect(element('.subtitle').text()).toContain "track\n"

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
