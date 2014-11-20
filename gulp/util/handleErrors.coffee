notify = require 'gulp-notify'

module.exports = ->
  args = Array::slice.call(arguments)

  # Send error to notification center with gulp-notify
  # notify.onError
  #   title: 'Compile Error'
  #   message: '<%= error.message %>'
  # .apply this, args

  # Just log to console.
  notify.onError
    title: 'Compile Error'
    message: '<%= error.toString().substr( error.toString().indexOf("/src/") ) %>'
    notifier: (options, callback) ->
  .apply this, args

  # Keep gulp from hanging on this task
  @emit 'end'

