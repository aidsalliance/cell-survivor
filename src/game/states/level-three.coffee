Level = require '../classes/level'

class LevelThree extends Level
  constructor: ->
    super
      slowest   : 100
      fastest   : 200
      spawnRate : .2
      complete  : 400
      next      : 'levelThreeComplete'

module.exports = LevelThree
