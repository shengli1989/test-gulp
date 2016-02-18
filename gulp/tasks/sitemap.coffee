{ $, gulp, basePath, dest, data } = require 'gulp-config'

gulp.task 'sitemap', ->
  gulp.src "#{dest.pages}**/*.html"
    .pipe $.sitemap(
      siteUrl: data.site.url
    )
    .pipe gulp.dest(dest.pages)
