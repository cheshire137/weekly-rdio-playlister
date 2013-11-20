class LastfmChart
  constructor: (data) ->
    @from = data.from
    @to = data.to
    @tracks = []

  track_range: ->
    range = []
    for i in [0...@tracks.length] by 3
      range.push i
    range

  from_date: ->
    new Date(1000 * @from)

  to_date: ->
    new Date(1000 * @to)

  from_date_str: ->
    moment(@from_date()).format('MMMM D, YYYY')

  to_date_str: ->
    moment(@to_date()).format('MMMM D, YYYY')

  from_date_utc_str: ->
    @from_date().toUTCString()

  to_date_utc_str: ->
    @to_date().toUTCString()

  to_s: ->
    "#{@from_date_str()} to #{@to_date_str()}"

(exports ? this).LastfmChart = LastfmChart
