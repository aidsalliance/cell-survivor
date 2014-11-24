Level = require '../classes/level'

class LevelFour extends Level
  constructor: ->
    super
      slowest   : 100
      fastest   : 200
      spawnRate : .3
      complete  : 0
      gameOver  : 'levelFourGameOver'
      powerups  : ['blank','blank','blank','blank','blank','blank']

module.exports = LevelFour
