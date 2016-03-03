{ basePath, dest, readData } = G

gulp.task 'sitemap', ->
  gulp.src "#{dest.pages}**/*.html"
    .pipe $.sitemap(
      siteUrl: readData('global').site.url
    )
    .pipe gulp.dest(dest.pages)
