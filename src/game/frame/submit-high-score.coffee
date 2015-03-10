$ = require 'jquery'

clearMessages = () ->
  $ '#high-score-form .success'
    .html ''
  $ '#high-score-form .error'
    .html ''

showSuccess = (msg) ->
  $ '#high-score-form .success'
    .html "&nbsp; #{msg} &nbsp;"
  $ '#high-score-form .error'
    .html ''
  window.gameRef.score = 0
  $ '#high-score-form input, #high-score-form h4, #high-score-form button'
    .fadeOut 200

showError = (msg) ->
  $ '#high-score-form .success'
    .html ''
  $ '#high-score-form .error'
    .html "&nbsp; #{msg} &nbsp;"
  $ '#high-score-form input, #high-score-form h4, #high-score-form button'
    .fadeOut 200

onResponse = (data, textStatus, jqXHR) ->
  if 'made-top-ten!' == data
    showSuccess 'Congratulations! You made <a href="./high-scores.html">this month’s top ten!</a>'
  else if 'missed-out!' == data
    showSuccess 'Sorry, you didn’t score enough to reach <a href="./high-scores.html">this month’s top ten!</a>'
  else
    showError data
  setTimeout resetEnterInitials, 2000


onFail = (msg) ->
  console.log 'server error details:', msg
  showError 'Sorry there was a server error. See console.log for details :-('
  setTimeout resetEnterInitials, 2000


resetEnterInitials = ->
  $ '#high-score-form'
    .css 'display', 'none'
  $ '#high-score-form-score'
    .text ''

  # if @game.device.desktop
  #   @upKey     = @game.input.keyboard.addKey Phaser.Keyboard.UP
  #   @downKey   = @game.input.keyboard.addKey Phaser.Keyboard.DOWN
  #   @leftKey   = @game.input.keyboard.addKey Phaser.Keyboard.LEFT
  #   @rightKey  = @game.input.keyboard.addKey Phaser.Keyboard.RIGHT

  #   @cKey      = @game.input.keyboard.addKey Phaser.Keyboard.C
  #   @pKey      = @game.input.keyboard.addKey Phaser.Keyboard.P
  #   @cKey.onDown.add @clickCondom, @
  #   @pKey.onDown.add @clickPill, @

  #   @enterKey  = @game.input.keyboard.addKey Phaser.Keyboard.ENTER
  #   @nEnterKey = @game.input.keyboard.addKey Phaser.Keyboard.NUMPAD_ENTER
  #   @spaceKey  = @game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
  #   @enterKey.onDown.add  @onDown, @
  #   @nEnterKey.onDown.add @onDown, @
  #   @spaceKey.onDown.add  @onDown, @
  # @game.input.keyboard.removeKey @upKey


onSubmitHighScore = (evt) ->
  clearMessages()
  # window.gameRef.score = 3000
  evt.preventDefault()
  $form = $ '#high-score-form'
  $initials = $ '#high-score-form input[name="initials"]'
  jqxhr = $.ajax
      type:    $form.attr 'method'
      url:     $form.attr 'action'
      data:
        initials: $initials.val()
        score: window.gameRef.score
      # success: onResponse
    .done onResponse
    .fail onFail

$(
  $ '#high-score-form button[type="submit"]'
    .click onSubmitHighScore
)
