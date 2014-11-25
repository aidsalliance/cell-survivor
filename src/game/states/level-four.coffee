Level = require '../classes/level'

class LevelFour extends Level
  constructor: ->
    super
      slowest   : 80
      fastest   : 130
      spawnRate : .06
      complete  : 0
      gameOver  : 'levelFourGameOver'
      powerups  : ['blank','blank','blank','blank','blank','blank']

  create: ->
    super
    @game.step = 9
    @game.frameCount = 0 # time a short delay before explaining missing powerups

module.exports = LevelFour
