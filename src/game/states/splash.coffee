$ = require 'jquery'
Message = require '../classes/message'

class Splash extends Message
  constructor: ->
    super
      banner: 'cell-survivor-logo'
      text: [
        'A cell is going about its daily business, protecting the body from intruders...'
      ]
      button: 'PLAY'
      afterword: 'This game may not be appropriate for younger children.'
      next: 'levelOne'

  create: ->
    super
    $('.wrap').addClass('loaded')

    if not @game.suppressBasicPopups then @game.suppressBasicPopups = false # after the player reaches level 2, don’t show the first three popups

    # Audio
    @audioTrack = @game.add.audio 'audio-track'
    @audioTrack.play('', 0, 1, true)



module.exports = Splash

