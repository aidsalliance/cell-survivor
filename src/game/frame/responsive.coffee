$ = require 'jquery'

onResize = ->
  width = $(window).width()
  height = $(window).height()
  if 1 > width / height then resizePortrait(width, height) else resizeLandscape(width, height)

resizePortrait = (width, height) ->
  width = Math.min height - 200, width # don’t squash header/footer to less than 100px height
  $ '.wrap'
    .addClass 'portrait'
  $ '.wrap .frame'
    .css
      height: (height - width) / 2
  $ '.wrap #main canvas'
    .css
      width:  width
      height: width

resizeLandscape = (width, height) ->
  height = Math.min width - 200, height # don’t squash either sidebar to less than 100px width
  $ '.wrap'
    .removeClass 'portrait'
  $ '.wrap #main canvas'
    .css
      width:  height
      height: height
  

# Call our resize function each time the window dimensions change @todo ensure that mobile orientation change fires this event
$(window).resize(onResize)

# Call our resize function when the page loads
onResize()