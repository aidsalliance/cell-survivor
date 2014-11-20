window.onload = ->
  'use strict'

  Phaser = require 'phaser'

  game = new Phaser.Game 800, 600, Phaser.AUTO, 'cell-survivor'

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
  game.state.add 'levelFour'         , require './states/level-four'
  game.state.add 'levelFourGameOver' , require './states/level-four-game-over'
  game.state.add 'gameOver'          , require './states/game-over'

  # Initialise the game
  game.state.start 'boot'
