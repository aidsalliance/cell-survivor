Level = require '../classes/level'

class LevelFour extends Level
  constructor: ->
    super 150, 300, .5, 0, null # slowest, fastest, spawnRate, complete (zero for no completion possible), next (null, level 4 can only end in game over)

module.exports = LevelFour
