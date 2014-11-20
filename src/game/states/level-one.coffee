Level = require '../classes/level'

class LevelOne extends Level
  constructor: ->
    super 50, 150, .1, 100, 'levelOneComplete' # slowest, fastest, spawnRate, complete, next

module.exports = LevelOne
