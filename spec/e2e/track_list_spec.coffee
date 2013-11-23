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

    it 'has a playlist creation form', ->
      expect(element('form.create-playlist').count()).toBe 1

    it 'has no info about a new playlist', ->
      expect(element('.created-playlist').count()).toBe 0

    describe 'create playlist', ->
      beforeEach ->
        element('form.create-playlist input[type="submit"]').click()

      it 'displays info about the new playlist', ->
        expect(element('.created-playlist').count()).toBe 1

      it 'displays the new playlist name', ->
        el = element('.created-playlist .playlist-name')
        expect(el.text()).toContain 'October 13-20, 2013'

      it 'displays the track count of the new playlist', ->
        el = element('.created-playlist .track-count')
        expect(el.text()).toContain '2'
        expect(el.text()).toContain 'tracks'

      it 'displays the image for the new playlist', ->
        expect(element('.created-playlist .playlist img').count()).toBe 1

      it 'highlights the matched track', ->
        mbid = 'b6695955-aefd-4bcb-8ff4-d193bcfeee88'
        expect(element("##{mbid}.matched").count()).toBe 1

      it 'highlights the missing track', ->
        mbid = '07436946-4d54-46f7-a2f6-165df3b7348c'
        expect(element("##{mbid}.missing").count()).toBe 1

      it 'does not highlight any track as both missing and matched', ->
        expect(element('.missing.matched').count()).toBe 0

      it 'displays a notice with the track count', ->
        notice = 'Successfully created playlist with 2 tracks!'
        expect(element('.notifications .alert-success').text()).toContain notice

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

    it 'does not have a playlist creation form', ->
      expect(element('form.create-playlist').count()).toBe 0

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
