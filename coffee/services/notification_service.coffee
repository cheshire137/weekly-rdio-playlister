playlister_app.factory 'Notification', ($timeout) ->
  class Notification
    constructor: ->
      @notices = []
      @errors = []
      @delay = 5000

    remove: (type, id) ->
      if type == 'error'
        @errors.splice(idx, 1) for idx, error of @errors when error.id == id
      else
        @notices.splice(idx, 1) for idx, notice of @notices when notice.id == id

    error: (message) ->
      return unless message
      console.error message
      id = @errors.length + 1
      self_remove = =>
        @remove('error', id)
      $timeout(self_remove, @delay)
      @errors.push
        message: message
        id: id

    notice: (message) ->
      return unless message
      id = @notices.length + 1
      self_remove = =>
        @remove('notice', id)
      $timeout(self_remove, @delay)
      @notices.push
        message: message
        id: id

  new Notification()
