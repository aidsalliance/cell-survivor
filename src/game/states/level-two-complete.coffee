Message = require '../classes/message'

class LevelTwoComplete extends Message
  constructor: ->
    super
      title: 'Level 2 Complete!'
      text: [
        'Well done for using your condoms! If you’re a young person living somewhere like Burundi or Bangladesh, condoms may not be readily available.'
        'Now move on to level 3 to find out how treatment can keep people living with HIV healthy.'
      ]
      button: 'START LEVEL 3'
      next: 'levelThree'

module.exports = LevelTwoComplete

