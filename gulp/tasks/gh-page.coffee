gulp.task 'gh-page', ->
  gulp.src("#{G.basePath.archive}**/*")
    .pipe $.ghPages()
