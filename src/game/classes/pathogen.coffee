class Pathogen extends Phaser.Sprite
  constructor: (game, x, y) ->
    spec = game.rnd.pick [
        { key:'hep-c-virus-main'        , name:'hep-c'        , anim:['pathogen_1.png', 'pathogen_4.png'] }
      , { key:'herpesviridae-virus-main', name:'herpesviridae', anim:['pathogen_2.png', 'pathogen_5.png'] }
    ]
    super game, x, y, spec.key

    game.physics.enable @, Phaser.Physics.ARCADE

    # @animations.add('spin', spec.anim, 50, true, false);

    @name = spec.name
    @anchor.set 0.5, 0.5
    # @checkWorldBounds = true

    @body.collideWorldBounds = true
    @body.bounce.set 1


module.exports = Pathogen
