Message = require '../classes/message'

class LevelFourGameOver extends Message
  constructor: ->
    super
      title: 'Game Over'
      text: [
        'Not easy was it with no extra help?'
        'Now imagine if you’re young and live with HIV in a country where access to information and help to keep you healthy are very limited.'
        'For more information about how the International HIV/AIDS Alliance is supporting young people, visit www.aidsalliance.org'
      ]
      button: 'PLAY AGAIN'
      next: 'levelOne'

module.exports = LevelFourGameOver

