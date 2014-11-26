Message = require '../classes/message'

class LevelThreeComplete extends Message
  constructor: ->
    super
      title: 'Level 3 Complete!'
      text: [
        'Think that was hard?'
        'Imagine having to take medication twice a day that can cause side effects.'
        'That’s the reality for many young people living with HIV who are on treatment.'
        'Ready for the final level?'
      ]
      button: 'START LEVEL 4'
      next: 'levelFour'

module.exports = LevelThreeComplete

