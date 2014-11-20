Level = require '../classes/level'

class LevelOne extends Level
  constructor: ->
    super
      slowest   : 50
      fastest   : 150
      spawnRate : .1
      complete  : 100
      next      : 'levelOneComplete'

module.exports = LevelOne
