$ = require 'jquery'
Level = require '../classes/level'

class LevelOne extends Level
  constructor: ->
    super
      slowest   : 55
      fastest   : 75
      spawnRate : .03
      complete  : 0 # complete when first hiv exits the screen
      next      : 'levelOneComplete'
      gameOver  : 'levelOneComplete' # doesn’t matter if the player cannot complete level 1
      powerups  : ['blank','blank','blank','blank','blank','blank']
      hivExit   : true

  create: ->
    super
    @game.step = 0
    @game.score = 0
    @game.frameCount = 0
    @game.hasDefended = false
    @game.hasLostWall = false
    @game.infected = false
    $ '#score'
      .text @game.score


module.exports = LevelOne
