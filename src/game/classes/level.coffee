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
    power = ( $(el).attr 'src' ).split('-')[1]?.split('.')[0]
    if 'condom' == power then @shieldUp()
    if 'pill'   == power then @buildWall()
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
      spec = if (angle / 6) % 2 > .7 then { key:'hep-c-brick-main', name:'hep-c' } else { key:'herpesviridae-brick-main', name:'herpesviridae' }
      brick = @game.bricks.create opposite, adjacent, spec.key
      brick.name = spec.name
      brick.scale.setTo 2, 2
      brick.angle = 180 + angle * -360 / 20
      brick.smoothed = false
      brick.anchor.setTo .5, .5 #center
      brick.body.immovable = true

  create: ->
    $(window).trigger 'resize' # ensure ‘onResize()’ is run

    # Add powerups, if specified
    self = @
    for powerup, i in @opt.powerups ?= [] # conditional assignment
      if !powerup then continue # skip a `null` powerup
      $ "#powerup-#{i} img"
        .attr 'src', "assets/images/icon-#{powerup}.gif"
        .off 'click', -> self.powerup(@) # remove event listener, if present
        .on  'click', -> self.powerup(@)


    @isPortrait = $ '.wrap'
      .hasClass 'portrait'

    if @isPortrait
      @game.world.setBounds 0, 0, 696, 600
      @game.camera.x = 48
      @background = @add.tileSprite 48, 0, 600, 600, 'cellfield'
      @createVeinWall 'vein-wall-header', -90, 648, 0
      @createVeinWall 'vein-wall-footer', -90, 648, 570
      @endZone = @world.width - 24 # width of pathogen
    else
      @game.world.setBounds 0, 0, 600, 696
      @game.camera.y = 48
      @background = @add.tileSprite 0, 48, 600, 600, 'cellfield'
      @createVeinWall 'vein-wall-header', 0,   0, 0
      @createVeinWall 'vein-wall-footer', 0, 570, 0
      @endZone = @world.height - 24 # height of pathogen

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

  update: ->

    # Rotate cell wall
    x = @input.position.x
    y = @input.position.y
    cx = @world.centerX
    cy = @world.centerY
    angle = Math.atan2(y - cy, x - cx) * (180 / Math.PI)
    @game.bricks.angle = angle

    # Remove pathogens which have traversed the screen
    if @isPortrait
      @pathogens.forEach( # callback, callbackContext, checkExists
        (pathogen) =>
          if pathogen?.x >= @endZone then pathogen.destroy()
          # console.log 'ok!', @endZone, pathogen?.x
      )
    else
      @pathogens.forEach( # callback, callbackContext, checkExists
        (pathogen) =>
          if pathogen?.y >= @endZone then pathogen.destroy()
      )


    # Remove shield, if the timer has elapsed
    if @game.shieldTimer? && 0 > --@game.shieldTimer
      delete @game.shieldTimer
      @game.shield?.destroy()

    if @game.shieldTimer?

      # Destroy all pathogens which touch the shield, or are inside it
      @pathogens.forEach(
        (pathogen) =>
          dx = Math.abs pathogen?.x - cx
          if 150 < dx then return # cannot be inside shield
          dy = Math.abs pathogen?.y - cy
          if 150 < dy then return # cannot be inside shield
          hyp = Math.sqrt dx * dx + dy * dy
          if 150 < hyp then return # skirted around corner
          pathogen?.destroy()
      )

    else

      # Process collisions bewtween pathogens and the cell
      @physics.arcade.collide @pathogens, @nucleus    , @pathogenHitNucleus, null, @
      @physics.arcade.collide @pathogens, @game.bricks, @pathogenHitBrick  , null, @

      # Possibly introduce a new pathogen
      if not @rnd.between 0, 1 / @opt.spawnRate # call `newPathogen()` if `between()` returns zero
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


  pathogenHitNucleus: ->
    @game.state.start @opt.gameOver ? 'gameOver'


  pathogenHitBrick: (pathogen, brick) ->

    if pathogen.name == brick.name
      @game.score += 10
      $ '#score'
        .text @game.score
    else
      brick.kill()

    pathogen.kill()

    if @game.score >= @opt.complete
      @game.state.start @opt.next


module.exports = Level
