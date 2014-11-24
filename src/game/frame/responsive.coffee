$ = require 'jquery'

onResize = ->
  width = $(window).width()
  height = $(window).height()
  if 1 > width / height then resizePortrait(width, height) else resizeLandscape(width, height)

# @todo fix for square-ish window shape

resizePortrait = (width, height) ->
  width = Math.min height - 108, width # don’t squash header/footer to less than 54px height
  $ '.wrap'
    .addClass 'portrait'
  $ '.wrap .frame'
    .css
      height: (height - width) / 2
  $ '.wrap .frame >div'
    .css
      width:  '100%'
      height: 54
  $ '.wrap #main canvas'
    .css
      width:  width
      height: width
  $ '.wrap .frame >div img'
    .css
      width: if 350 > width then 48 else 54 # 320px width



resizeLandscape = (width, height) ->
  height = Math.min width - 108, height # don’t squash either sidebar to less than 54px width
  $ '.wrap'
    .removeClass 'portrait'
  $ '.wrap .frame >div'
    .css
      width:  (height - 20) / 7
      height: height - 20
  $ '.wrap #main canvas'
    .css
      width:  height
      height: height
  $ '.wrap .frame >div img'
    .css
      width: '100%'
  

# Call our resize function each time the window dimensions change @todo ensure that mobile orientation change fires this event
$(window).resize(onResize)

# Call our resize function when the page loads
onResize()