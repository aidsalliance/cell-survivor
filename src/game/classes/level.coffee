$        = require 'jquery'
Pathogen = require '../classes/pathogen'
Brick    = require '../classes/brick'

class Level
  constructor: (@opt) ->

  createVeinWall: (name, angle, x, y) ->
    @veinWall = @add.tileSprite 0, 48, 15, 600, name
    @veinWall.angle = angle
    @veinWall.x = x
    @veinWall.y = y
    @veinWall.autoScroll 0, @opt.slowest / 4
    @veinWall.scale.setTo 2, 2

  powerup: (el) ->
    # console.log @, el, $(el).parent().attr('id'),
    powerup = ( $(el).attr 'src' ).split('-')[1]?.split('.')[0]
    if 'condom' == powerup then @shieldUp()
    if 'pill'   == powerup then @buildWall()
    $(el).attr 'src', 'assets/images/icon-blank.gif'

  shieldUp: () ->
    @game.shieldTimer = 300
    @game.shield?.destroy()
    @game.shield = @add.graphics @world.centerX, @world.centerY
    @game.shield.lineStyle  2, 0x0000ff
    @game.shield.drawCircle 0, 0, 260
    @game.shield.lineStyle  2, 0x0088ff
    @game.shield.drawCircle 0, 0, 262
    @game.shield.lineStyle  2, 0x00ffff
    @game.shield.drawCircle 0, 0, 264
    
  buildWall: () ->
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

  showPopup: (msg) ->
    @game.paused = true
    $ '#popup-text'
      .html msg + '<br><br>'
    $ '#popup-wrap'
      .fadeIn()

  create: ->
    $(window).trigger 'resize' # ensure ‘onResize()’ is run

    @relativeComplete = @game.score + @opt.complete

    # Add powerups, if specified
    self = @
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
      @createVeinWall 'vein-wall-header', -90, 672, 0
      @createVeinWall 'vein-wall-footer', -90, 672, 570
      @endZone = @world.width - 36 # width of widest pathogen
    else
      @game.world.setBounds 0, 0, 600, 744
      @game.camera.y = 72
      @background = @add.tileSprite 0, 72, 600, 600, 'cellfield'
      @createVeinWall 'vein-wall-header', 0,   0, 0
      @createVeinWall 'vein-wall-footer', 0, 570, 0
      @endZone = @world.height - 36 # height of highest pathogen

    @background.scale.setTo 6, 6

    @nucleus = @add.sprite @world.centerX, @world.centerY, 'nucleus-main'
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


  rotateWall: ->
    x = @input.position.x
    y = @input.position.y
    cx = @world.centerX
    cy = @world.centerY

    dx = Math.abs x - cx
    dy = Math.abs y - cy
    hyp = Math.sqrt dx * dx + dy * dy
    if 130 > hyp then return # too close to nucleus

    angle = Math.atan2(y - cy, x - cx) * (180 / Math.PI)
    @game.bricks.angle = angle

  update: ->
    @game.frameCount++

    @rotateWall()

    # First popup message
    if 0 == @game.step and 80 < @game.frameCount
      @game.step = 1
      if @game.device.desktop
        @showPopup 'Move your mouse to rotate the cell wall.'
      else
        @showPopup 'Swipe in a circle to rotate the cell wall.'

    # Ninth popup message
    else if 9 == @game.step and 80 < @game.frameCount
      @game.step = 10
      @showPopup 'Oh no! The supply of condoms and pills has run out, this will be really challenging...'

    # Remove pathogens which have traversed the screen
    if @isPortrait
      @pathogens.forEach( # callback, callbackContext, checkExists
        (pathogen) =>
          if pathogen?.x >= @endZone
            if @opt.hivExit and 'hiv' == pathogen.name
              @game.state.start @opt.next
            pathogen.destroy()
          # console.log 'ok!', @endZone, pathogen?.x
      )
    else
      @pathogens.forEach( # callback, callbackContext, checkExists
        (pathogen) =>
          if pathogen?.y >= @endZone
            if @opt.hivExit and 'hiv' == pathogen.name
              @game.state.start @opt.next
            pathogen.destroy()
      )


    # Remove shield, if the timer has elapsed
    if @game.shieldTimer? && 0 > --@game.shieldTimer
      delete @game.shieldTimer
      @game.shield?.destroy()

    if @game.shieldTimer?

      # Destroy all pathogens which touch the shield, or are inside it
      @pathogens.forEach(
        (pathogen) =>
          dx = Math.abs pathogen?.x - @world.centerX
          if 160 < dx then return # cannot be inside shield
          dy = Math.abs pathogen?.y - @world.centerY
          if 160 < dy then return # cannot be inside shield
          hyp = Math.sqrt dx * dx + dy * dy
          if 160 < hyp then return # skirted around corner
          pathogen?.destroy()
      )

    else

      # Process collisions bewtween pathogens and the cell
      @physics.arcade.collide @pathogens, @nucleus    , @pathogenHitNucleus, null, @
      @physics.arcade.collide @pathogens, @game.bricks, @pathogenHitBrick  , null, @

      # Decide whether to add a new green or blue virus
      if 1 == @game.frameCount
        doSpawn = true # always spawn on frame 1 of a level
      else if 50 > @game.frameCount
        doSpawn = not @rnd.between 0, 10 / @opt.spawnRate # spawn less at the start of a level
      else
        doSpawn = not @rnd.between 0, 1 / @opt.spawnRate

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
        if 3 <= @game.step and 4 != @game.step and not @rnd.between 0, (if 3 == @game.step then 5 else 15)
          pathogen.loadTexture 'hiv-virus-main'
          pathogen.name = 'hiv'
          pathogen.scale.setTo 3, 3
          if 3 == @game.step
            @showPopup 'Watch out for the HIV virus: it will infect the cell if it touches!'
            @game.step = 4
            if @isPortrait
              pathogen.y = @world.centerY + 100
              pathogen.body.velocity =
                x: 40
                y: 20
            else
              pathogen.x = @world.centerX + 100
              pathogen.body.velocity =
                x: 20
                y: 40
          if 5 == @game.step
            @showPopup 'Defend the cell against HIV by clicking one of the condom buttons.'
            @game.step = 6


  pathogenHitNucleus: ->
    @game.state.start @opt.gameOver ? 'gameOver'


  pathogenHitBrick: (pathogen, brick) ->

    if pathogen.name == brick.name
      @game.score += 10
      $ '#score'
        .text @game.score

      # Second or third popup message (on level 1)
      if not @game.hasDefended and (1 == @game.step or 2 == @game.step)
        @game.step = if 1 == @game.step then 2 else 3
        @game.hasDefended = true
        @showPopup "Well done! #{brick.name} sections of the cell wall defend against #{pathogen.name} viruses."

    else if 6 == @game.step and 'hiv' == pathogen.name
      @showPopup "[cell infection animation to happen now]"
      @game.step = 7
      @game.state.start 'levelTwoComplete'

    else
      brick.kill()

      # Second or third popup message (on level 1)
      if not @game.hasLostWall and (1 == @game.step or 2 == @game.step)
        @game.step = if 1 == @game.step then 2 else 3
        @game.hasLostWall = true
        @showPopup "Oh no! #{pathogen.name} viruses destroy #{brick.name} sections of the cell wall."

      # Eighth popup message (on level 3)
      else if 7 == @game.step
        @game.step = 8
        @showPopup 'Click on an antiretroviral pill to repair the cell wall.'

    pathogen.kill()

    if @opt.complete and @game.score >= @relativeComplete # set `@opt.complete` to zero to make a level which can not be completed by reaching a certain score
      @game.state.start @opt.next

  onDown: ->
    console.log 123
    @game.paused = false
    $ '#popup-wrap'
      .fadeOut()

module.exports = Level
