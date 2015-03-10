window.onload = ->
  'use strict'

  Phaser = require 'phaser'

  window.gameRef = game = new Phaser.Game 600, 600, Phaser.AUTO, 'cell-survivor' # for 'onSubmitHighScore()'

  # Game states
  game.state.add 'boot'              , require './states/boot'
  game.state.add 'preloader'         , require './states/preloader'

  game.state.add 'splash'            , require './states/splash'
  game.state.add 'levelOne'          , require './states/level-one'
  game.state.add 'levelOneComplete'  , require './states/level-one-complete'
  game.state.add 'levelTwo'          , require './states/level-two'
  game.state.add 'levelTwoComplete'  , require './states/level-two-complete'
  game.state.add 'levelThree'        , require './states/level-three'
  game.state.add 'levelThreeComplete', require './states/level-three-complete'
  game.state.add 'levelThreeGameOver', require './states/level-three-game-over'
  game.state.add 'levelFour'         , require './states/level-four'
  game.state.add 'levelFourGameOver' , require './states/level-four-game-over'
  game.state.add 'gameOver'          , require './states/game-over'

  # Helpers
  require './frame/responsive'
  require './frame/submit-high-score'

  # Initialise the game
  game.state.start 'boot'
