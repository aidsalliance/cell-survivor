Pathogen = require '../classes/pathogen'
Brick    = require '../classes/brick'

class Game

  create: ->

    @background = @add.tileSprite 0, 0, 800, 600, 'cellfield'

    # x = @game.width / 2
    # y = @game.height / 2
    # @player = @add.sprite x, y, 'player'
    # @player.anchor.setTo 0.5, 0.5
    # @input.onDown.add @onInputDown, this

    @nucleus = @add.sprite @world.centerX, @world.centerY, 'breakin', 'nucleus.png'
    @physics.enable @nucleus, Phaser.Physics.ARCADE
    @nucleus.scale.setTo 4, 4
    @nucleus.anchor.setTo 0.5, 0.5
    @nucleus.body.collideWorldBounds = true
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

    for angle in [0..39]
      opposite = Math.sin(angle * Math.PI / 20) * 100
      adjacent = Math.cos(angle * Math.PI / 20) * 100
      frame = if (angle / 6) % 2 > .7 then 'pathogen_1.png' else 'pathogen_2.png'
      brick = @bricks.create opposite, adjacent, 'breakin', frame
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
    @physics.arcade.collide @pathogens, @bricks , @pathogenHitBrick

    if not @rnd.between 0, 100 # call `newPathogen()` if `between()` returns zero
      @pathogens.create @rnd.between(0, @world.width), 0


  pathogenHitNucleus: ->
    @game.state.start 'menu'


  pathogenHitBrick: (pathogen, brick) ->
    # brickColor    = if '3' == brick._frame.name[6] then 'red' else 'blue'
    brickColor    = if '1' ==    brick._frame.name[9] || '4' ==    brick._frame.name[9] then 'blue' else 'red'
    pathogenColor = if '1' == pathogen._frame.name[9] || '4' == pathogen._frame.name[9] then 'blue' else 'red'

    if brickColor != pathogenColor
      brick.kill();
    else
      # score += 10
      # scoreText.text = 'score: ' + score

    pathogen.kill();

    # score += 10
    # if score >= 200
    #   introText.text = 'Level 1 Complete'
    #   introText.visible = true
    #   game.paused = true


module.exports = Game
