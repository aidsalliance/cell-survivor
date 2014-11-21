Message = require '../classes/message'

class GameOver extends Message
  constructor: ->
    super
      title: 'Game Over'
      text: [
        'AIDS-related illnesses are the second leading cause of death among adolescents aged 10–19 years globally and the first in Africa.'
        'Contracting HIV need not be ‘Game Over’ but a comprehensive package of prevention, treatment, care and support is needed for this overlooked age group.'
        'To find out more, visit www.aidsalliance.org'
      ]
      button: 'PLAY AGAIN'
      next: 'levelOne'

  create: ->
    super
    @game.score = 0

module.exports = GameOver

