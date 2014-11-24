Level = require '../classes/level'

class LevelTwo extends Level
  constructor: ->
    super
      slowest   : 60
      fastest   : 130
      spawnRate : .05
      complete  : 200
      next      : 'levelTwoComplete'
      powerups  : ['condom','condom','condom','blank','blank','blank']

module.exports = LevelTwo
