{ $, gulp, basePath, dest, readConfig } = require 'gulp-config'

gulp.task 'sitemap', ->
  gulp.src "#{dest.pages}**/*.html"
    .pipe $.sitemap(
      siteUrl: readConfig('data').site.url
    )
    .pipe gulp.dest(dest.pages)
