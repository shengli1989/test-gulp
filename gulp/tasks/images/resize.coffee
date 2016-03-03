{ basePath, src, dest } = G

gulp.task 'images:resize', ->
  config = require("#{basePath.config}resize-image")
  gulp.src(["#{dest.images}**/*", "!#{dest.images}{r,r/**/*}"])
    .pipe $.responsive.apply(null, config)
    .pipe gulp.dest("#{dest.images}r/")
