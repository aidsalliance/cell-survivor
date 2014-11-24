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

  create: ->
    $(window).trigger 'resize' # ensure ‘onResize()’ is run

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

    # @scoreText = @game.add.text(32, 550, 'score: ' + @game.score, { font: "20px Arial", fill: "#ffffff", align: "left" });

    @nucleus = @add.sprite @world.centerX, @world.centerY, 'nucleus-main'
    @physics.enable @nucleus, Phaser.Physics.ARCADE
    @nucleus.smoothed = false
    @nucleus.scale.setTo 3, 3
    @nucleus.anchor.setTo 0.5, 0.5
    # @nucleus.body.collideWorldBounds = true
    @nucleus.body.bounce.set 1
    @nucleus.body.immovable = true

    @pathogens = @add.group()
    @pathogens.enableBody = true
    @pathogens.physicsBodyType = Phaser.Physics.ARCADE
    @pathogens.classType = Pathogen

    @bricks = @add.group()
    @bricks.enableBody = true
    @bricks.physicsBodyType = Phaser.Physics.ARCADE
    @bricks.classType = Brick
    @bricks.x = @world.centerX
    @bricks.y = @world.centerY

    for angle in [0..19]
      opposite = Math.sin(angle * Math.PI / 10) * 110
      adjacent = Math.cos(angle * Math.PI / 10) * 110
      spec = if (angle / 6) % 2 > .7 then { key:'hep-c-brick-main', name:'hep-c' } else { key:'herpesviridae-brick-main', name:'herpesviridae' }
      brick = @bricks.create opposite, adjacent, spec.key
      brick.name = spec.name
      brick.scale.setTo 2, 2
      brick.angle = 180 + angle * -360 / 20
      brick.smoothed = false
      brick.anchor.setTo .5, .5 #center
      brick.body.immovable = true


  update: ->
    x = @input.position.x
    y = @input.position.y
    cx = @world.centerX
    cy = @world.centerY

    angle = Math.atan2(y - cy, x - cx) * (180 / Math.PI)
    @bricks.angle = angle

    # dx = x - cx
    # dy = y - cy
    # scale = Math.sqrt(dx * dx + dy * dy) / 100
    # @bricks.scale.x = scale * 0.6
    # @bricks.scale.y = scale * 0.6

    @physics.arcade.collide @pathogens, @nucleus, @pathogenHitNucleus, null, @
    @physics.arcade.collide @pathogens, @bricks , @pathogenHitBrick, null, @

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
