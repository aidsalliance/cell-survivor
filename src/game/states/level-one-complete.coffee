Message = require '../classes/message'

class LevelOneComplete extends Message
  constructor: ->
    super
      title: 'Level 1 Complete!'
      text: [
        'Feeling under the weather?  In some countries if you’re under 19 you may not even be able to take an HIV test to know your status.'
        'There are an estimated 2.1 million adolescents living with HIV – many still don’t know that they are and so are not yet on life-saving treatment.'
      ]
      button: 'START LEVEL 2'
      next: 'levelTwo'

module.exports = LevelOneComplete
