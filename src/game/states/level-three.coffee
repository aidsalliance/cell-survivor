Level = require '../classes/level'

class LevelThree extends Level
  constructor: ->
    super
      slowest   : 80
      fastest   : 160
      spawnRate : .1
      complete  : 400
      next      : 'levelThreeComplete'
      powerups  : ['condom','condom','condom','pill','pill','pill']

module.exports = LevelThree
