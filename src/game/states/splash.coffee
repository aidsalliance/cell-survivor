Message = require '../classes/message'

class Splash extends Message
  constructor: ->
    super
      title: 'Cell Survivor'
      text: [
        'A cell is going about its daily business, protecting the body from intruders...'
      ]
      button: 'PLAY'
      next: 'levelOne'

module.exports = Splash

