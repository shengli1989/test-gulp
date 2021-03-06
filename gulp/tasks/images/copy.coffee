{ src, dest } = G

gulp.task 'images:copy', ->
  gulp.src "#{src.images}**/*.{jpg,jpeg,png,gif,svg,cur}"
    .pipe $.imagemin {progressive: true}
    .pipe gulp.dest(dest.images)
