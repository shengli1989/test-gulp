{ basePath, dest, readData } = G

gulp.task 'sitemap', ->
  gulp.src "#{dest.pages}**/*.html"
    .pipe $.sitemap(
      siteUrl: readData('meta').site.url
    )
    .pipe gulp.dest(dest.pages)
