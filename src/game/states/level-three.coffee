Level = require '../classes/level'

class LevelThree extends Level
  constructor: ->
    super
      slowest   : 70
      fastest   : 120
      spawnRate : .05
      complete  : 500 # will be added to the current score in `create()`
      next      : 'levelThreeComplete'
      gameOver  : 'levelThreeGameOver'
      powerups  : ['condom','condom','condom','pill','pill','pill']

module.exports = LevelThree
