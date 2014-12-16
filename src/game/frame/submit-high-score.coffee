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
  $ '#high-score-form input, #high-score-form button'
    .fadeOut 200

showError = (msg) ->
  $ '#high-score-form .success'
    .html ''
  $ '#high-score-form .error'
    .html "&nbsp; #{msg} &nbsp;"
  $ '#high-score-form input'
    .focus()

onResponse = (data, textStatus, jqXHR) ->
  if 'made-top-ten!' == data
    showSuccess 'Congratulations! You made <a href="./high-scores.html">this month’s top ten!</a>'
  else if 'missed-out!' == data
    showSuccess 'Sorry, you didn’t score enough to reach <a href="./high-scores.html">this month’s top ten!</a>'
  else
    showError data

onFail = (msg) ->
  console.log 'server error details:', msg
  showError 'Sorry there was a server error. See console.log for details :-('

onSubmitHighScore = (evt) ->
  clearMessages()
  window.gameRef.score = 3000
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
