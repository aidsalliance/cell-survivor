Level = require '../classes/level'

class LevelTwo extends Level
  constructor: ->
    super 100, 250, .2, 200, 'levelTwoComplete' # slowest, fastest, spawnRate, complete, next

module.exports = LevelTwo
