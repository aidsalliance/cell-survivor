Message = require '../classes/message'

class Splash extends Message
  constructor: ->
    super
      banner: 'cell-survivor-logo'
      text: [
        'A cell is going about its daily business, protecting the body from intruders...'
      ]
      button: 'PLAY'
      afterword: 'If you are under 16 years of age, please obtain a parent’s or a guardian’s permission before playing this game.'
      next: 'levelOne'

  create: ->
    super

    if not @game.suppressBasicPopups then @game.suppressBasicPopups = false # after the player reaches level 2, don’t show the first three popups

    # Audio
    @audioTrack = @game.add.audio 'audio-track'
    @audioTrack.play('', 0, 1, true)



module.exports = Splash

