class GameOver

  @titleTxt = null
  @startTxt = null

  create: ->
    x = @game.width / 2
    y = @game.height / 2

    @titleTxt = @add.bitmapText(x, y, 'minecraftia', 'Game Over')
    @titleTxt.align = 'center'
    @titleTxt.x = @game.width / 2 - @titleTxt.textWidth / 2

    y = y + @titleTxt.height + 5
    @startTxt = @add.bitmapText(x, y, 'minecraftia', 'PLAY AGAIN')
    @startTxt.align = 'center'
    @startTxt.x = @game.width / 2 - @startTxt.textWidth / 2

    @input.onDown.add @onDown, this

  update: ->

  onDown: ->
    @game.score = 0
    @game.state.start 'levelOne'

module.exports = GameOver
