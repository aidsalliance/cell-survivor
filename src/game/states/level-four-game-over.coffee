Message = require '../classes/message'

class LevelFourGameOver extends Message
  constructor: ->
    super
      title: 'Game Over'
      text: [
        'Not easy was it with no extra help?'
        'Now imagine if you’re a young person living with HIV in a country where access to information and services to keep you healthy and fulfilled are either limited or non-existent…'
        'To find out more, visit www.aidsalliance.org'
      ]
      button: 'PLAY AGAIN'
      next: 'levelOne'

  create: ->
    super
    @game.score = 0

module.exports = LevelFourGameOver

