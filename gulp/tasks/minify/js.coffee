{ dest } = G

gulp.task 'minify:js', ->
  gulp.src("#{dest.scripts}*.js")
    .pipe $.uglify()
    .pipe gulp.dest(dest.scripts)
