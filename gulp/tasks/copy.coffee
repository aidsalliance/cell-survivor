gulp = require 'gulp'

gulp.task 'copy', ->
  gulp.src('./src/index.html').pipe gulp.dest './build'
  gulp.src('./src/assets/fonts/*').pipe gulp.dest './build/assets/fonts'
  gulp.src('./src/assets/audio/*').pipe gulp.dest './build/assets/audio'

