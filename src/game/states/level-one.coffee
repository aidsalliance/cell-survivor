$ = require 'jquery'
Level = require '../classes/level'

class LevelOne extends Level
  constructor: ->
    super
      slowest   : 40
      fastest   : 80
      spawnRate : .03
      complete  : 100
      next      : 'levelOneComplete'
      powerups  : ['condom','condom','pill','pill','blank','blank']

  create: ->
    super
    @game.step = 0
    @game.score = 0
    @game.frameCount = 0
    $ '#score'
      .text @game.score


module.exports = LevelOne
