Level = require '../classes/level'

class LevelFour extends Level
  constructor: ->
    super
      slowest   : 80
      fastest   : 160
      spawnRate : .1
      complete  : 0
      gameOver  : 'levelFourGameOver'
      powerups  : ['blank','blank','blank','blank','blank','blank']

module.exports = LevelFour
