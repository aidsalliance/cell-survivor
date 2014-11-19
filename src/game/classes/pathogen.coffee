class Pathogen extends Phaser.Sprite
  constructor: (game, x, y) ->
    color = game.rnd.pick [
        { start:'pathogen_1.png', anim:['pathogen_1.png', 'pathogen_4.png'] }
      , { start:'pathogen_2.png', anim:['pathogen_2.png', 'pathogen_5.png'] }
    ]
    super game, x, y, 'breakin', color.start

    game.physics.enable @, Phaser.Physics.ARCADE

    # @animations.add('spin', color.anim, 50, true, false);

    @anchor.set 0.5
    @checkWorldBounds = true

    @body.collideWorldBounds = true
    @body.bounce.set 1

    @body.velocity =
      x: game.rnd.between -200, 200
      y: game.rnd.between 50, 200


module.exports = Pathogen
