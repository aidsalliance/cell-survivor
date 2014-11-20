Message = require '../classes/message'

class LevelThreeComplete extends Message
  constructor: ->
    super
      title: 'Level 3 Complete!'
      text: [
        'Think that was hard?  Imagine having to take twice daily medication that consists of lots of very large pills, tastes horrible and can cause nasty side effects.'
        'That’s the reality for young people living with HIV who are on antiretroviral treatment.'
      ]
      button: 'START LEVEL 4'
      next: 'levelFour'

module.exports = LevelThreeComplete

