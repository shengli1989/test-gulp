{ $, gulp, basePath, src, dest } = require 'gulp-config'

gulp.task 'images:resize', ->
  config = require("#{basePath.root}/#{basePath.config}resize-image")
  gulp.src("#{dest.images}**/*")
    .pipe $.responsive.apply(null, config)
    .pipe gulp.dest("#{dest.images}")