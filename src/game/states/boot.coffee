$ = require 'jquery'

class Boot

  preload: ->
    $(window).trigger 'resize' # ensure ‘onResize()’ is run
    @load.image 'preloader', 'assets/images/preloader.gif'

  create: ->
    @game.input.maxPointers = 1
    @game.state.start 'preloader'

module.exports = Boot
