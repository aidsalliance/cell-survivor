$        = require 'jquery'
Pathogen = require '../classes/pathogen'
Brick    = require '../classes/brick'

class Level
  constructor: (@opt) ->

  createVeinWall: (name, angle, x, y) ->
    @veinWall = @add.tileSprite 0, 96, 30, 600, name
    @veinWall.angle = angle
    @veinWall.x = x
    @veinWall.y = y
    @veinWall.autoScroll 0, @opt.slowest / 4
    @veinWall.scale.setTo 1, 1

  powerup: (el) ->
    if not ({ 'levelTwo':1, 'levelThree':1, 'levelFour':1  })[@game.state.current] then return
    if @game.paused then return
    # console.log @, el, $(el).parent().attr('id'),
    powerup = ( $(el).attr 'src' ).split('-')[1]?.split('.')[0]
    if 'condom' == powerup then @shieldUp()
    if 'pill'   == powerup then @buildWall()
    $(el).attr 'src', 'assets/images/icon-blank.gif'

  shieldUp: () ->
    @game.shieldTimer = 300
    @game.shield?.destroy()
    @game.shield = @add.graphics @world.centerX, @world.centerY
    @game.shield.lineStyle  4, 0x6e2a8d
    @game.shield.drawCircle 0, 0, 270
    @game.shield.lineStyle  3, 0xd60c8c
    @game.shield.drawCircle 0, 0, 274
    @game.shield.lineStyle  2, 0xf8c1d9
    @game.shield.drawCircle 0, 0, 278
    @sfx.shieldUp.play()
    
  buildWall: () ->
    @game.damage = 0
    @game.bricks?.destroy()

    @game.bricks = @add.group()
    @game.bricks.enableBody = true
    @game.bricks.physicsBodyType = Phaser.Physics.ARCADE
    @game.bricks.classType = Brick
    @game.bricks.x = @world.centerX
    @game.bricks.y = @world.centerY

    for angle in [0..19]
      opposite = Math.sin(angle * Math.PI / 10) * 110
      adjacent = Math.cos(angle * Math.PI / 10) * 110
      spec = if (angle / 6) % 2 > .7 then { key:'hep-c-brick-main', name:'green' } else { key:'herpesviridae-brick-main', name:'blue' }
      brick = @game.bricks.create opposite, adjacent, spec.key
      brick.name = spec.name
      brick.scale.setTo 2, 2
      brick.angle = 180 + angle * -360 / 20
      brick.smoothed = false
      brick.anchor.setTo .5, .5 #center
      brick.body.immovable = true

    @sfx.pill.play()

  showPopup: (msg) ->
    # console.log @game.furthestStep
    if @game.suppressBasicPopups and 3 >= @game.step then return # don’t show the first three popups after the player has reached level 2 @todo remove this old system?
    if @game.furthestStep >= @game.step then return # don’t show the same popup twice inthe player’s session
    @game.furthestStep = Math.max @game.furthestStep, @game.step
    if ! @game.showHelp then return # comment-out to always remove all popups
    @sfx.popup.play()
    $ '#popup-note'
      .html ''
    $ '#popup-text'
      .html msg + '<br>'
    $ '#popup-wrap'
      .fadeIn()
    setTimeout (=>
      @game.paused = true)
      , 400
    if @game.device.desktop
      setTimeout (=>
        $ '#popup-note'
          .html '...press spacebar to continue...')
        , 1800


  create: ->
    @levelFrameCount = 0 # a frame-count which resets each level

    #$(window).trigger 'resize' # ensure ‘onResize()’ is run
    $('#textlink').hide()

    @sfx =
      pathogen  : @game.add.audio 'pathogen'
      brick     : @game.add.audio 'brick'
      shieldUp  : @game.add.audio 'shield-up'
      shieldDown: @game.add.audio 'shield-down'
      pill      : @game.add.audio 'pill'
      popup     : @game.add.audio 'popup'
      infected  : @game.add.audio 'infected'
      endOfLevel: @game.add.audio 'end-of-level'
      gameOver  : @game.add.audio 'game-over'

    @relativeComplete = @game.score + @opt.complete

    @lastInputPosX = -9999
    @lastInputPosY = -9999

    self = @

    if ! @game.device.desktop
      $ '#popup-inner'
        .on 'click', -> self.onDown()
    else
      @upKey     = @game.input.keyboard.addKey Phaser.Keyboard.UP
      @downKey   = @game.input.keyboard.addKey Phaser.Keyboard.DOWN
      @leftKey   = @game.input.keyboard.addKey Phaser.Keyboard.LEFT
      @rightKey  = @game.input.keyboard.addKey Phaser.Keyboard.RIGHT

      @cKey      = @game.input.keyboard.addKey Phaser.Keyboard.C
      @pKey      = @game.input.keyboard.addKey Phaser.Keyboard.P
      @cKey.onDown.add @clickCondom, @
      @pKey.onDown.add @clickPill, @

      @enterKey  = @game.input.keyboard.addKey Phaser.Keyboard.ENTER
      @nEnterKey = @game.input.keyboard.addKey Phaser.Keyboard.NUMPAD_ENTER
      @spaceKey  = @game.input.keyboard.addKey Phaser.Keyboard.SPACEBAR
      @enterKey.onDown.add  @onDown, @
      @nEnterKey.onDown.add @onDown, @
      @spaceKey.onDown.add  @onDown, @


    # Add powerups, if specified
    for powerup, i in @opt.powerups ?= [] # conditional assignment
      if !powerup then continue # skip a `null` powerup
      $ "#powerup-#{i} img"
        .attr 'src', "assets/images/icon-#{powerup}.gif"
        .off 'click', -> self.powerup(@) # remove event listener, if present
        .on  'click', -> self.powerup(@)

    delete @game.shieldTimer # prevent previously active shield from continuing

    @input.onDown.add @onDown, @

    @isPortrait = $ '.wrap'
      .hasClass 'portrait'

    if @isPortrait
      @game.world.setBounds 0, 0, 744, 600
      @game.camera.x = 72
      @background = @add.tileSprite 72, 0, 600, 600, 'cellfield'
      @createVeinWall 'vein-wall-header', 90, 672, 0
      @createVeinWall 'vein-wall-footer', 90, 672, 570
      @endZone = @world.width - 36 # width of widest pathogen
    else
      @game.world.setBounds 0, 0, 600, 744
      @game.camera.y = 72
      @background = @add.tileSprite 0, 72, 600, 600, 'cellfield'
      @createVeinWall 'vein-wall-header', 0,   0, 72
      @createVeinWall 'vein-wall-footer', 0, 570, 72
      @endZone = @world.height - 36 # height of highest pathogen

    @background.scale.setTo 6, 6

    @nucleus = @add.sprite @world.centerX, @world.centerY, if @game.infected then 'nucleus-infected-2' else 'nucleus-main'
    @physics.enable @nucleus, Phaser.Physics.ARCADE
    @nucleus.smoothed = false
    @nucleus.scale.setTo 3, 3
    @nucleus.anchor.setTo 0.5, 0.5
    @nucleus.body.bounce.set 1
    @nucleus.body.immovable = true

    @pathogens = @add.group()
    @pathogens.enableBody = true
    @pathogens.physicsBodyType = Phaser.Physics.ARCADE
    @pathogens.classType = Pathogen

    @buildWall()


  clickCondom: -> # player has pressed the 'c' key
    $firstButton = ($ "#footer img[src='assets/images/icon-condom.gif']")
    if 0 == $firstButton.length then return
    $firstButton?.first().trigger 'click'


  clickPill: -> # player has pressed the 'p' key
    $firstButton = ($ "#footer img[src='assets/images/icon-pill.gif']")
    if 0 == $firstButton.length then return
    $firstButton?.first().trigger 'click'


  rotateWall: -> # @todo touchscreen-specific alternate function, to avoid `if @game.device.desktop` etc
    x = @input.position.x
    y = @input.position.y

    keyPower = false
    if @game.device.desktop
      if @downKey.isDown
        keyPower = 2.5
      else if @upKey.isDown
        keyPower = -2.5
      else if @rightKey.isDown
        keyPower = .8
      else if @leftKey.isDown
        keyPower = -.8

    if keyPower
      @game.bricks.angle += keyPower
      @lastInputPosX = x
      @lastInputPosY = y
    else if @lastInputPosX != x and @lastInputPosY != y

      half  = window.gameHalfEdgeLength # @world.centerX an Y are only useful at 100% scale
      tenth = window.gameTenthEdgeLength

      dx = x - half
      dy = y - half

      if -tenth < dx < tenth and -tenth < dy < tenth then return # too close to nucleus

      angle = Math.atan2(dy, dx) * (180 / Math.PI)
      @game.bricks.angle = angle

  update: ->
    @levelFrameCount++

    @rotateWall()

    # First popup message
    if 0 == @game.step and 80 < @levelFrameCount
      @game.step = 1
      if @game.device.desktop
        @showPopup '<h4>Move your mouse or use the arrow keys to rotate the cell wall.</h4>'
      else
        @showPopup '<h4>Swipe in a circle to rotate the cell wall.</h4>'

    # Ninth popup message
    else if 9 == @game.step and 80 < @levelFrameCount
      @game.step = 10
      @showPopup '<h4>Oh no! The supply of <span class="pink">condoms</span> and <span class="blue">pills</span> has run out, this will be really challenging...</h4>'

    # Remove pathogens which have traversed the screen
    if @isPortrait
      @pathogens.forEach( # callback, callbackContext, checkExists
        (pathogen) =>
          if pathogen?.x >= @endZone
            if @opt.hivExit and 'hiv' == pathogen.name
              @sfx.endOfLevel.play()
              setTimeout (=>
                @game.state.start @opt.next)
                , 600
            pathogen.destroy()
      )
    else
      @pathogens.forEach( # callback, callbackContext, checkExists
        (pathogen) =>
          if pathogen?.y >= @endZone
            if @opt.hivExit and 'hiv' == pathogen.name
              @sfx.endOfLevel.play()
              setTimeout (=>
                @game.state.start @opt.next)
                , 600
            pathogen.destroy()
      )


    # Remove shield, if the timer has elapsed
    if @game.shieldTimer? && 0 > --@game.shieldTimer
      @sfx.shieldDown.play()
      delete @game.shieldTimer
      @game.shield?.destroy()

    if @game.shieldTimer?

      # Destroy all pathogens which touch the shield, or are inside it
      @pathogens.forEach(
        (pathogen) =>
          if not pathogen? then return
          dx = Math.abs pathogen.x - @world.centerX
          if 160 < dx then return # cannot be inside shield
          dy = Math.abs pathogen.y - @world.centerY
          if 160 < dy then return # cannot be inside shield
          hyp = Math.sqrt dx * dx + dy * dy
          if 160 < hyp then return # skirted around corner
          @explode pathogen
      )

    else

      # Process collisions bewtween pathogens and the cell
      @physics.arcade.collide @pathogens, @nucleus    , @pathogenHitNucleus, null, @
      @physics.arcade.collide @pathogens, @game.bricks, @pathogenHitBrick  , null, @

      # Decide whether to add a new green or blue virus
      if 1 == @levelFrameCount
        doSpawn = true # always spawn on frame 1 of a level
      else if 50 > @levelFrameCount
        doSpawn = not @rnd.between 0, (@pathogens.length * 5) / @opt.spawnRate # spawn less at the start of a level
      else
        doSpawn = not @rnd.between 0, @pathogens.length / (@opt.spawnRate + (@levelFrameCount * 0.00005))

      # Possibly add a new green or blue virus
      if doSpawn # call `newPathogen()` if `between()` returns zero
        if @isPortrait
          pathogen = @pathogens.create 0, @rnd.between(0, @world.height)
          pathogen.body.velocity =
            x: @game.rnd.between @opt.slowest, @opt.fastest
            y: @game.rnd.between -@opt.fastest, @opt.fastest
        else
          pathogen = @pathogens.create @rnd.between(0, @world.width), 0
          pathogen.body.velocity =
            x: @game.rnd.between -@opt.fastest, @opt.fastest
            y: @game.rnd.between @opt.slowest, @opt.fastest

        pathogen.scale.setTo 2, 2
        pathogen.smoothed = false

        # Possibly convert the pathogen to an HIV virus
        if 6 < @game.damage and 3 <= @game.step and 4 != @game.step and not @rnd.between 0, (if 3 == @game.step then 4 else 10)
          pathogen.loadTexture 'hiv-virus-main'
          pathogen.name = 'hiv'
          pathogen.scale.setTo 3, 3
          if 'levelOne' == @game.state.current
            @showPopup '<h4>Watch out for the <span class="aqua">HIV virus</span>. <br>It will infect the cell if it touches!</h4>'
            @game.step = 4
            if @isPortrait
              pathogen.y = @world.centerY + 100
              pathogen.body.velocity =
                x: 60
                y: 30
            else
              pathogen.x = @world.centerX + 100
              pathogen.body.velocity =
                x: 30
                y: 60
          if 5 == @game.step
            if @game.device.desktop
              @showPopup '<h4>Defend the cell against HIV by clicking one of the <span class="pink">condom buttons</span>, or press ‘c’.</h4>'
            else
              @showPopup '<h4>Defend the cell against HIV by clicking one of the <span class="pink">condom buttons</span>.</h4>'
            @game.step = 6


  gameOver: ->
    setTimeout (=>
      @game.state.start @opt.gameOver ? 'gameOver')
      , 1200


  pathogenHitNucleus: ->
    @explode @nucleus
    @sfx.gameOver.play()
    @gameOver()


  pathogenHitBrick: (pathogen, brick) ->
    if 'hiv' == pathogen.name
      pathogen.body.bounce.set .2 # heavy

    if pathogen.name == brick.name
      @sfx.pathogen.play()

      @game.score += 10
      $ '#score'
        .text @game.score

      # Second or third popup message (on level 1)
      if not @game.hasDefended and (1 == @game.step or 2 == @game.step)
        @game.step = if 1 == @game.step then 2 else 3
        @game.hasDefended = true
        @showPopup "<h4>Well done! <span class='#{brick.name}'>#{brick.name}</span> sections of the cell wall defend against <span class='#{pathogen.name}'>#{pathogen.name}</span> viruses (and vice versa).</h4>"

    else if 6 == @game.step and 'hiv' == pathogen.name
      @game.infected = true
      @sfx.infected.play()
      setTimeout (=>
        @nucleus.loadTexture 'nucleus-infected-1')
        , 400
      setTimeout (=>
        @game.paused = true # comment this out to hide popups @todo test the game does not mysteriously pause, the second time round in a session
        @nucleus.loadTexture 'nucleus-infected-2')
        , 800
      setTimeout (=>
        @showPopup "<h4>Now the cell has been infected with HIV, but it’s not ‘Game Over’...</h4>"
        @nucleus.loadTexture 'nucleus-infected-3')
        , 1200
      setTimeout (=>
        @game.step = 7
        @game.state.start 'levelTwoComplete')
        , 1500
      return # don’t destroy the HIV 

    else
      @explode brick
      @sfx.brick.play()
      @game.damage++

      # Second or third popup message (on level 1)
      if not @game.hasLostWall and (1 == @game.step or 2 == @game.step)
        @game.step = if 1 == @game.step then 2 else 3
        @game.hasLostWall = true
        @showPopup "<h4>Oh no! <span class='#{pathogen.name}'>#{pathogen.name}</span> viruses destroy <span class='#{brick.name}'>#{brick.name}</span> sections of the cell wall (and vice versa).</h4>"

      # Eighth popup message (on level 3)
      else if 7 == @game.step
        @game.step = 8
        if @game.device.desktop
          @showPopup '<h4>Click on an <span class="blue">antiretroviral pill</span> or press ‘p’ to repair the cell wall.</h4>'
        else
          @showPopup '<h4>Click on an <span class="blue">antiretroviral pill</span> to repair the cell wall.</h4>'
          

    @explode pathogen

    if @opt.complete and @game.score >= @relativeComplete # set `@opt.complete` to zero to make a level which can not be completed by reaching a certain score
      @sfx.endOfLevel.play()
      setTimeout (=>
        @game.state.start @opt.next)
        , 600

  explode: (sprite) ->
    if      'hep-c-virus-main' == sprite.key
      keyPrefix = 'hep-c-virus-explosion-'
    else if 'hep-c-brick-main' == sprite.key
      keyPrefix = 'hep-c-brick-explosion-'
    else if 'herpesviridae-virus-main' == sprite.key
      keyPrefix = 'herpesviridae-virus-explosion-'
    else if 'herpesviridae-brick-main' == sprite.key
      keyPrefix = 'herpesviridae-brick-explosion-'
    else if 'hiv-virus-main' == sprite.key
      keyPrefix = 'hiv-virus-explosion-'
    else if 'nucleus-main' == sprite.key
      keyPrefix = 'nucleus-infected-'
    else if 'nucleus-infected-1' == sprite.key
      keyPrefix = 'nucleus-infected-'
    if !keyPrefix then return
    setTimeout (->
      sprite.loadTexture keyPrefix + '1')
      , 100
    setTimeout (->
      sprite.loadTexture keyPrefix + '2')
      , 300
    setTimeout (->
      sprite.destroy() )
      , 500

  onDown: ->
    @game.paused = false
    $ '#popup-wrap'
      .fadeOut()

module.exports = Level
