Message = require '../classes/message'

class LevelTwoComplete extends Message
  constructor: ->
    super
      title: 'Level 2 Complete!'
      text: [
        'Well done for using your condoms!  If you’re a young person living somewhere like Bangladesh or Ethiopia, condoms may not be readily available.'
        'An estimated 13 billion condoms per year are needed to help halt the spread of HIV and other sexually transmitted infections. The actual number falls far short…'
      ]
      button: 'START LEVEL 3'
      next: 'levelThree'

module.exports = LevelTwoComplete

