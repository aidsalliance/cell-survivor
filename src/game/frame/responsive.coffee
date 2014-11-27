$ = require 'jquery'

onResize = ->
  width = $(window).width()
  height = $(window).height()
  if 1 > width / height then resizePortrait(width, height) else resizeLandscape(width, height)

# @todo fix for square-ish window shape

resizePortrait = (width, height) ->
  width = Math.min height - 108, width # don’t squash header/footer to less than 54px height
  window.gameEdgeLength     = width
  window.gameHalfEdgeLength = width / 2
  $ '.wrap'
    .addClass 'portrait'
  $ '.wrap .frame'
    .css
      height: (height - width) / 2
  $ '.wrap .frame >div'
    .css
      width:  '100%'
      height: 54
  $ '#fb-iframe'
    .css
      width:  54 / 4
      height: 54 / 4
  $ '.wrap #main canvas'
    .css
      width:  width
      height: width
  $ '#textlink'
    .css
      top: (height - width) / 2 + (width * .5)
      left: 0
      width: '100%'
  $ '#textlink a'
    .css
      height: width * .1
  $ '#popup-wrap'
    .css
      top: (height - width) / 2 + 40
      left: 0
      width: '100%'
  $ '#popup-inner'
    .css
      width: '80%'
  $ '.wrap .frame >div img'
    .css
      width: if 350 > width then 48 else 54 # 320px width
  $ '.bold-bitmap'
    .css
      'font-size': width / 40 # was 25
  $ '.bold-bitmap-small' # @todo remove this
    .css
      'font-size': height / 40


resizeLandscape = (width, height) ->
  height = Math.min width - 108, height # don’t squash either sidebar to less than 54px width
  window.gameHalfEdgeLength  = height / 2  # used by `rotateWall()` in `Level`
  window.gameTenthEdgeLength = height / 10 # used by `rotateWall()` in `Level`
  $ '.wrap'
    .removeClass 'portrait'
  $ '.wrap .frame >div'
    .css
      width:  (height - 20) / 7
      height: height - 20
  $ '#fb-iframe'
    .css
      width:  (height - 20) / 28 # 7 * 4
      height: (height - 20) / 28 # 7 * 4
  $ '.wrap #main canvas'
    .css
      width:  height
      height: height
  $ '#textlink'
    .css
      top: height * .5
      left: (width - height) / 2 + (height * .1)
      width: height * .8
  $ '#textlink a'
    .css
      height: height * .1
  $ '#popup-wrap'
    .css
      top: height * .1 # 10%
      left: (width - height) / 2 + (height * .1)
      width: height * .8
  $ '#popup-inner'
    .css
      width: height * .8 # 80%
  $ '.wrap .frame >div img'
    .css
      width: '100%'
  $ '.bold-bitmap'
    .css
      'font-size': height / 25
  $ '.bold-bitmap-small'
    .css
      'font-size': height / 40


# Call our resize function each time the window dimensions change @todo ensure that mobile orientation change fires this event
$(window).resize(onResize)

# Call our resize function when the page loads
onResize()