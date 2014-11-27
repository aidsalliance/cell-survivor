$ = require 'jquery'

class Message
  @titleTxt  = null
  @textTxt   = null
  @buttonTxt = null

  constructor: (@opt) ->

  wrapper: (len) ->
    # http://james.padolsey.com/javascript/wordwrap-for-javascript/
    regex = '.{1,' + len + '}(\\s|$)' + (if false then '|.{' + len + '}|.+$' else '|\\S+?(\\s|$)')
    return RegExp regex, 'g'

  create: ->
    $(window).trigger 'resize' # ensure ‘onResize()’ is run

    @enterKey  = @game.input.keyboard.addKey Phaser.Keyboard.ENTER
    @nEnterKey = @game.input.keyboard.addKey Phaser.Keyboard.NUMPAD_ENTER
    @spaceKey  = @game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
    @enterKey.onDown.add  @onDown, @
    @nEnterKey.onDown.add @onDown, @
    @spaceKey.onDown.add  @onDown, @

    x = @game.width / 2
    y = 50

    if @opt.banner
      @banner = @add.sprite x, y, @opt.banner
      @banner.smoothed = false
      @banner.scale.setTo 4, 4
      @banner.anchor.setTo 0.5, 0
      y += @banner.height + 10

    if @opt.title
      @titleTxt = @add.bitmapText x, y, 'minecraftia', @opt.title
      @titleTxt.align = 'center'
      @titleTxt.x = @game.width / 2 - @titleTxt.textWidth / 2
      y = y + @titleTxt.height + 50

    for section in @opt.text

      # Qik n dirty removal of ‘Well done for using your condoms! ’ where none were used
      if -1 != section.indexOf('Well done for using your condoms! ')
        if 3 == $('img[src="assets/images/icon-condom.gif"]').length
          section = section.substr 34

      text = section.match( @wrapper 48 ).join '\n'
      @textTxt = @game.add.text x, y, text, { font: "24px Arial", fill: "#ffffff", align: "center" }
      @textTxt.anchor.setTo 0.5, 0
      y = y + @textTxt.height + 30

    if @opt.textlink
      $('#textlink').show()
    else
      $('#textlink').hide()

    if @opt.button
      @buttonBackground = @add.sprite x, y, 'button-background'
      @buttonBackground.smoothed = false
      @buttonBackground.scale.setTo 4, 4
      @buttonBackground.anchor.setTo 0.5, 0
      y += 15
      @buttonTxt = @add.bitmapText x, y, 'minecraftia', @opt.button
      @buttonTxt.align = 'center'
      @buttonTxt.x = @game.width / 2 - @buttonTxt.textWidth / 2
      y += @buttonBackground.height + 10

    if @opt.footer
      @footer = @add.sprite x, y, @opt.footer
      @footer.smoothed = false
      @footer.scale.setTo 1, 1
      @footer.anchor.setTo 0.5, 0
      y += @footer.height + 10

    if @opt.afterword
      text = @opt.afterword.match( @wrapper 35 ).join '\n'
      @afterword = @game.add.text x, y, text, { font: "18px Arial", fill: "#ffffff", align: "center" }
      # @afterword.lineSpacing = '30px'
      @afterword.anchor.setTo 0.5, 0
      y = y + @afterword.height + 30

    @input.onDown.add @onDown, @

  update: ->

  onDown: ->
    @game.state.start @opt.next


module.exports = Message
