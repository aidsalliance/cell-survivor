Message = require '../classes/message'

class LevelOneComplete extends Message
  constructor: ->
    super
      title: 'Level 1 Complete!'
      text: [
        'Feeling under the weather? In some countries if you’re under 19 you may not even be able to take an HIV test to know whether you carry the virus.'
        'There are an estimated 2.1 million young people living with HIV – many don’t know that they have the virus and are not  yet on life-saving treatment.'
      ]
      button: 'START LEVEL 2'
      next: 'levelTwo'

module.exports = LevelOneComplete
