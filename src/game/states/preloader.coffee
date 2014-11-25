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

    @load.image 'cellfield'                      , 'assets/images/bkgnd-v2.jpg'
    @load.image 'vein-wall-header'               , 'assets/images/vein-wall-header.gif'
    @load.image 'vein-wall-footer'               , 'assets/images/vein-wall-footer.gif'
    @load.image 'hep-c-brick-main'               , 'assets/images/hep-c-brick-main.gif'
    @load.image 'hep-c-brick-explosion-1'        , 'assets/images/hep-c-brick-explosion-1.gif'
    @load.image 'hep-c-brick-explosion-2'        , 'assets/images/hep-c-brick-explosion-2.gif'
    @load.image 'hep-c-virus-main'               , 'assets/images/hep-c-virus-main.gif'
    @load.image 'hep-c-virus-explosion-1'        , 'assets/images/hep-c-virus-explosion-1.gif'
    @load.image 'hep-c-virus-explosion-2'        , 'assets/images/hep-c-virus-explosion-2.gif'
    @load.image 'herpesviridae-brick-main'       , 'assets/images/herpesviridae-brick-main.gif'
    @load.image 'herpesviridae-brick-explosion-1', 'assets/images/herpesviridae-brick-explosion-1.gif'
    @load.image 'herpesviridae-brick-explosion-2', 'assets/images/herpesviridae-brick-explosion-2.gif'
    @load.image 'herpesviridae-virus-explosion-1', 'assets/images/herpesviridae-virus-explosion-1.gif'
    @load.image 'herpesviridae-virus-explosion-2', 'assets/images/herpesviridae-virus-explosion-2.gif'
    @load.image 'herpesviridae-virus-main'       , 'assets/images/herpesviridae-virus-main.gif'
    @load.image 'hiv-virus-main'                 , 'assets/images/hiv-virus-main.gif'
    @load.image 'nucleus-main'                   , 'assets/images/nucleus-main.gif'

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start 'splash' unless not @ready

  onLoadComplete: ->
    @ready = true

module.exports = Preloader
