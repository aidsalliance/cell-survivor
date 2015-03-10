Message = require '../classes/message'

class LevelFourGameOver extends Message
  constructor: ->
    super
      title: 'Game NOT Over'
      text: [
        'Not easy was it with no extra help? Young people living with HIV can be supported to lead healthy and fulfilled lives if they have access to services, treatment, care and support.'
        'For more information about how the International HIV/AIDS Alliance is supporting young people, visit www.aidsalliance.org/worldAIDSday'
      ]
      button: 'PLAY AGAIN'
      footer: 'alliance-logo'
      next: 'levelOne'

  create: ->
    super

    if 2000 <= @game.score
      @popupEnterInitials()

    @game.step = 0
    @game.score = 0
    @game.frameCount = 0
    @game.hasDefended = false
    @game.hasLostWall = false
    @game.infected = false

module.exports = LevelFourGameOver

