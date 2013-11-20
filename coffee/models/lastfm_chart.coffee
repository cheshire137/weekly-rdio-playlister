class LastfmChart
  constructor: (data) ->
    @from = data.from
    @to = data.to
    @tracks = []

  track_range: ->
    range = []
    for i in [0...@tracks.length] by 4
      range.push i
    range

  from_date: ->
    new Date(1000 * @from)

  to_date: ->
    new Date(1000 * @to)

  from_date_str: ->
    date = @from_date()
    if date.getFullYear() == @to_date().getFullYear()
      moment(date).format('MMMM D')
    else
      moment(date).format('MMMM D, YYYY')

  to_date_str: ->
    from_date = @from_date()
    to_date = @to_date()
    same_year = from_date.getFullYear() == to_date.getFullYear()
    same_month = from_date.getMonth() == to_date.getMonth()
    if same_year && same_month
      moment(to_date).format('D, YYYY')
    else
      moment(to_date).format('MMMM D, YYYY')

  from_date_utc_str: ->
    @from_date().toUTCString()

  to_date_utc_str: ->
    @to_date().toUTCString()

  to_s: ->
    "#{@from_date_str()} to #{@to_date_str()}"

(exports ? this).LastfmChart = LastfmChart
