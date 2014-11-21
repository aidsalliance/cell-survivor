class Brick extends Phaser.Sprite
  constructor: (game, x, y, key) ->
    super game, x, y, key

    # @scale.setTo 2, 1
    # @body.bounce.set 1
    # @body.immovable = true

module.exports = Brick
