{ $, gulp, dest } = require 'gulp-config'
del = require 'del'

gulp.task 'minify:css', ->
  gulp.src("#{dest.style}*.css")
    .pipe $.cssnano({discardComments: {removeAll: true}})
    .pipe gulp.dest(dest.style)

  del("#{dest.style}*.css.map")
