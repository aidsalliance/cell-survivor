Message = require '../classes/message'

class LevelOneComplete extends Message
  constructor: ->
    super
      title: 'Level 1 Complete!'
      text: [
        'Feeling under the weather?'
        'Worldwide, there are an estimated 2.1 million adolescents living with HIV – many don’t know that they have the virus and are not on life-saving treatment yet.'
        'Now move on to level 2 and use your condoms to help prevent infection.'
      ]
      button: 'START LEVEL 2'
      next: 'levelTwo'

  create: ->
    super
    @game.suppressBasicPopups = true # don’t show the first three popups

module.exports = LevelOneComplete
