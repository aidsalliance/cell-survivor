window.onload = ->
  'use strict'

  Phaser = require 'phaser'

  game = new Phaser.Game 800, 600, Phaser.AUTO, 'wad14-game'

  # Game states
  game.state.add 'boot'             , require './states/boot'
  game.state.add 'preloader'        , require './states/preloader'

  game.state.add 'splash'           , require './states/splash'
  game.state.add 'levelOne'         , require './states/level-one'
  game.state.add 'levelOneComplete' , require './states/level-one-complete'
  game.state.add 'gameOver'         , require './states/game-over'

  game.state.start 'boot'
