$ = require 'jquery'

onHelpToggle = (evt) ->
  if window.gameRef.showHelp
    window.gameRef.showHelp = false
    $ '#help-toggle'
     .attr 'title', 'Click to show help popups'
    $ '#help-toggle img'
     .attr 'src', 'assets/images/icon-help-off.gif'
  else
    window.gameRef.showHelp = true
    $ '#help-toggle'
     .attr 'title', 'Click to hide help popups'
    $ '#help-toggle img'
     .attr 'src', 'assets/images/icon-help-on.gif'

$(
  $ '#help-toggle'
    .click onHelpToggle
)
