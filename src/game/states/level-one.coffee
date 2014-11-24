Level = require '../classes/level'

class LevelOne extends Level
  constructor: ->
    super
      slowest   : 40
      fastest   : 80
      spawnRate : .03
      complete  : 100
      next      : 'levelOneComplete'
      powerups  : ['blank','blank','blank','blank','blank','blank']

module.exports = LevelOne
