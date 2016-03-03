{ dest } = G
del = require 'del'

gulp.task 'minify:css', ->
  gulp.src("#{dest.styles}*.css")
    .pipe $.cssnano({discardComments: {removeAll: true}})
    .pipe gulp.dest(dest.styles)

  del("#{dest.styles}*.css.map")
