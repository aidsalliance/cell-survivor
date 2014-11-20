Level = require '../classes/level'

class LevelThree extends Level
  constructor: ->
    super 150, 400, .3, 400, 'levelThreeComplete' # slowest, fastest, spawnRate, complete, next

module.exports = LevelThree
