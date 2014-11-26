Message = require '../classes/message'

class GameOver extends Message
  constructor: ->
    super
      title: 'Game Over'
      text: [
        'Contracting HIV need not be ‘Game Over’ but prevention, treatment, and care is needed for young people who too often are overlooked.'
        'For more information about how the International HIV/AIDS Alliance is supporting young people, visit www.aidsalliance.org'
      ]
      button: 'PLAY AGAIN'
      next: 'levelOne'

  create: ->
    super
    @game.step = 0
    @game.score = 0
    @game.frameCount = 0
    @game.hasDefended = false
    @game.hasLostWall = false
    @game.infected = false

module.exports = GameOver

