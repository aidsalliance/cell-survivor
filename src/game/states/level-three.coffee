Level = require '../classes/level'

class LevelThree extends Level
  constructor: ->
    super
      slowest   : 150
      fastest   : 400
      spawnRate : .3
      complete  : 400
      next      : 'levelThreeComplete'

module.exports = LevelThree
