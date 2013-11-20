class LastfmChart
  constructor: (data) ->
    @from = data.from
    @to = data.to

  from_date: ->
    new Date(1000 * @from)

  to_date: ->
    new Date(1000 * @to)

  from_date_str: ->
    @from_date().toUTCString()

  to_date_str: ->
    @to_date().toUTCString()

  to_s: ->
    "#{@from_date_str()} to #{@to_date_str()}"

(exports ? this).LastfmChart = LastfmChart
