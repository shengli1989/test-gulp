{ $, gulp, dest } = require 'gulp-config'

gulp.task 'minify:html', ->
  gulp.src("#{dest.pages}**/*.html")
    .pipe $.htmlmin({collapseWhitespace: true})
    .pipe gulp.dest(dest.pages)
