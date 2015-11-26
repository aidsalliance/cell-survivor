$ = require 'jquery'

class Message
  @titleTxt  = null
  @textTxt   = null
  @buttonTxt = null

  constructor: (@opt) ->

  popupEnterInitials: ->
    $ '#high-score-form'
      .css 'display', 'block'
    $ '#high-score-form-score'
      .text window.gameRef.score
    $ '#high-score-form input'
      .focus()
    $ '#high-score-form input, #high-score-form h4, #high-score-form button'
      .fadeIn 200
    #@todo temporarily disable keyboard shortcuts

  showMessage: () ->
    # return # temporarily remove all popups
    @sfx.popup.play()
    msg = []

    if @opt.banner
      cache = @game.cache._images[@opt.banner] # @todo find less hacky way to retrieve the image meta
      msg.push "<div><img style=\"width:50%; height:auto;\" src=\"#{cache.url}\"></div>"

    if @opt.title
      msg.push "<h1>#{@opt.title}</h1>"

    for section in @opt.text
      if -1 != section.indexOf('Well done for using your condoms! ') # qik n dirty removal of ‘Well done for using your condoms! ’ where none were used
        if 3 == $('img[src="assets/images/icon-condom.gif"]').length
          section = section.substr 34
      if -1 != startPos = section.indexOf('www.aidsalliance.org/worldAIDSday')
        section = section.substr(0, startPos) + '<a title=\"Find out about World AIDS Day\" href="http://www.aidsalliance.org/worldAIDSday">www.aidsalliance.org/worldAIDSday</a>' + section.substr(startPos + 33)
      msg.push "<p>#{section}</p>"

    if @opt.button
      cache = @game.cache._images['button-background'] # @todo find less hacky way to retrieve the image meta
      msg.push "<h2 class=\"down-button\" style=\"background-image:url(#{cache.url})\"><a onclick=\"this.onDown\">#{@opt.button}</a></h2>"

    if @opt.footer
      cache = @game.cache._images[@opt.footer] # @todo find less hacky way to retrieve the image meta
      msg.push "<div><a title=\"Find out about World AIDS Day\" href=\"http://www.aidsalliance.org/worldAIDSday\"><img style=\"width:50%; height:auto;\" src=\"#{cache.url}\"></a></div>"

    if @opt.afterword
      msg.push "<h6>#{@opt.afterword}</h6>"

    $ '#popup-text'
      .html msg.join '\n'
    $ '#popup-dismiss'
      .off() # clear all previous click handlers
      .on 'click', =>
        @onDown()
      .css 'display', 'none'
    $ '.down-button'
      .off() # clear all previous click handlers
      .on 'click', =>
        @onDown()
    $ '#popup-note'
      .html ''
    $ '#popup-wrap'
      .fadeIn()
    if @game.device.desktop
      setTimeout (=>
        $ '#popup-note'
          .html '<h6>...press spacebar to continue...</h6>')
        , 1800

    $(window).trigger 'resize' # center the popup vertically

  wrapper: (len) ->
    # http://james.padolsey.com/javascript/wordwrap-for-javascript/
    regex = '.{1,' + len + '}(\\s|$)' + (if false then '|.{' + len + '}|.+$' else '|\\S+?(\\s|$)')
    return RegExp regex, 'g'

  create: ->

    @sfx =
      popup: @game.add.audio 'popup'

    @enterKey  = @game.input.keyboard.addKey Phaser.Keyboard.ENTER
    @nEnterKey = @game.input.keyboard.addKey Phaser.Keyboard.NUMPAD_ENTER
    @spaceKey  = @game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
    @enterKey.onDown.add  @onDown, @
    @nEnterKey.onDown.add @onDown, @
    @spaceKey.onDown.add  @onDown, @

    @showMessage()

  update: ->

  onDown: ->
    $ '#popup-wrap'
      .fadeOut()
    @game.state.start @opt.next


module.exports = Message
