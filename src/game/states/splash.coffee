Message = require '../classes/message'

class Splash extends Message
  constructor: ->
    super
      title: 'Cell Survivor'
      text: [
        'A CD4 cell is going about its daily business of protecting the body from infection.'
        'All of a sudden it comes under attack from HIV…'
      ]
      button: 'PLAY'
      next: 'levelOne'

  create: ->
    super
    @game.score = 0

module.exports = Splash

