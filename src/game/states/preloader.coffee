class Preloader

  @asset = null
  @ready = false

  preload: ->
    @asset = @add.sprite(320, 240, 'preloader')
    @asset.anchor.setTo 0.5, 0.5
    @load.onLoadComplete.addOnce @onLoadComplete, this
    @load.setPreloadSprite @asset
    @load.bitmapFont 'minecraftia', 'assets/fonts/minecraftia.png', 'assets/fonts/minecraftia.xml'

    # @load.atlas 'breakin', 'assets/images/breakin-v2.png', 'assets/images/breakin-v2.json'

    @load.image 'button-background'              , 'assets/images/button-background-v2.gif'
    @load.image 'cell-survivor-logo'             , 'assets/images/cell-survivor-logo-v1.gif'
    @load.image 'alliance-logo'                  , 'assets/images/alliance-logo-v1.gif'
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
    @load.image 'hiv-virus-explosion-1'          , 'assets/images/hiv-virus-explosion-1.gif'
    @load.image 'hiv-virus-explosion-2'          , 'assets/images/hiv-virus-explosion-2.gif'
    @load.image 'nucleus-main'                   , 'assets/images/nucleus-main.gif'
    @load.image 'nucleus-infected-1'             , 'assets/images/nucleus-infected-1.gif'
    @load.image 'nucleus-infected-2'             , 'assets/images/nucleus-infected-2.gif'
    @load.image 'nucleus-infected-3'             , 'assets/images/nucleus-infected-3.gif'

    @load.audio 'brick'                          , 'assets/audio/126428__cabeeno-rossley__toss-throw.wav'
    @load.audio 'pathogen'                       , 'assets/audio/150216__killkhan__menu-move-1-short.mp3'
    @load.audio 'shield-up'                      , 'assets/audio/ZipUp-Mark_E_B-8079_hifi.mp3'
    @load.audio 'shield-down'                    , 'assets/audio/150218__killkhan__menu-select-2.mp3'
    @load.audio 'pill'                           , 'assets/audio/58919__mattwasser__coin-up.mp3'
    @load.audio 'popup'                          , 'assets/audio/181602__coby12388__enerjump.wav'
    @load.audio 'infected'                       , 'assets/audio/150216__killkhan__menu-move-1.mp3'
    @load.audio 'end-of-level'                   , 'assets/audio/RewardSo-Mark_E_B-8078_hifi.mp3'
    @load.audio 'game-over'                      , 'assets/audio/43696__notchfilter__game-over01.wav'
    @load.audio 'audio-track'                    , 'assets/audio/Glass_Boy_-_09_-_Electronic_Yerba_Mate-short.mp3'

  create: ->
    @asset.cropEnabled = false

  update: ->
    @game.state.start 'splash' unless not @ready

  onLoadComplete: ->
    @ready = true

module.exports = Preloader
