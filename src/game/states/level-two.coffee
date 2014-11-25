Level = require '../classes/level'

class LevelTwo extends Level
  constructor: ->
    super
      slowest   : 60
      fastest   : 110
      spawnRate : .03
      complete  : 0 # completed when cell is touched by HIV
      next      : 'levelTwoComplete'
      powerups  : ['condom','condom','condom','blank','blank','blank']

  create: ->
    super
    @game.step = 5

module.exports = LevelTwo
