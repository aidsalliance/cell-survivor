class Preloader

  @asset = null
  @ready = false

  preload: ->
    @asset = @add.sprite(320, 240, 'preloader')
    @asset.anchor.setTo 0.5, 0.5
    @load.onLoadComplete.addOnce @onLoadComplete, this
    @load.setPreloadSprite @asset
    @load.image 'player', 'assets/images/player.png'
    @load.bitmapFont 'minecraftia', 'assets/fonts/minecraftia.png', 'assets/fonts/minecraftia.xml'

    @load.atlas 'breakin', 'assets/images/breakin-v2.png', 'assets/images/breakin-v2.json'
    @load.image 'cellfield', 'assets/images/cellfield.jpg'

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start 'menu' unless not @ready

  onLoadComplete: ->
    @ready = true

module.exports = Preloader
