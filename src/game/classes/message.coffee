$ = require 'jquery'

class Message
  @titleTxt  = null
  @textTxt   = null
  @buttonTxt = null

  constructor: (@opt) ->

  create: ->

    # Ensure ‘onResize()’ is run
    $ window
      .trigger 'resize'

    x = @game.width / 2
    y = 50

    @titleTxt = @add.bitmapText x, y, 'minecraftia', @opt.title
    @titleTxt.align = 'center'
    @titleTxt.x = @game.width / 2 - @titleTxt.textWidth / 2

    y = y + @titleTxt.height + 50

    # http://james.padolsey.com/javascript/wordwrap-for-javascript/
    regex = '.{1,' + 40 + '}(\\s|$)' + (if false then '|.{' + 40 + '}|.+$' else '|\\S+?(\\s|$)')

    for section in @opt.text
      text = section.match( RegExp(regex, 'g') ).join('\n')
      @textTxt = @game.add.text x, y, text, { font: "30px Arial", fill: "#ffffff", align: "center" }
      @textTxt.anchor.setTo 0.5, 0
      y = y + @textTxt.height + 30

    @buttonTxt = @add.bitmapText x, y, 'minecraftia', @opt.button
    @buttonTxt.align = 'center'
    @buttonTxt.x = @game.width / 2 - @buttonTxt.textWidth / 2

    @input.onDown.add @onDown, this

  update: ->

  onDown: ->
    @game.state.start @opt.next

module.exports = Message
