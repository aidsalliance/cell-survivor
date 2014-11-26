Message = require '../classes/message'

class GameOver extends Message
  constructor: ->
    super
      title: 'Game Over'
      text: [
        'Contracting HIV is not game over - young people can be supported to lead healthy and fulfilled lives.'
        'For more information about how the International HIV/AIDS Alliance is supporting young people, visit www.aidsalliance.org/worldAIDSday'
      ]
      textlink: true
      button: 'PLAY AGAIN'
      footer: 'alliance-logo'
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

