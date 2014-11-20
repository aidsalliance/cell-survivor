Level = require '../classes/level'

class LevelTwo extends Level
  constructor: ->
    super
      slowest   : 100
      fastest   : 250
      spawnRate : .2
      complete  : 200
      next      : 'levelTwoComplete'

module.exports = LevelTwo
