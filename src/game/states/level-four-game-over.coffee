Message = require '../classes/message'

class LevelFourGameOver extends Message
  constructor: ->
    super
      title: 'Game Over'
      text: [
        'Not easy was it with no extra help? But that’s what it’s like if you’re young and living with HIV in a country where access to help to keep you healthy is limited.'
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

module.exports = LevelFourGameOver

