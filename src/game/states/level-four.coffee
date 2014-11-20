Level = require '../classes/level'

class LevelFour extends Level
  constructor: ->
    super
      slowest   : 150
      fastest   : 300
      spawnRate : .5
      complete  : 0
      gameOver  : 'levelFourGameOver'

module.exports = LevelFour
