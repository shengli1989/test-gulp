{ basePath, src, dest } = G

fs = require 'fs'

gulp.task 'images:resize', (cb) ->
  config = require("#{basePath.config}image-breakpoints")

  gulp.src(["#{dest.images}**/*", "!#{dest.images}{r,r/**/*}"])
    .pipe $.responsive.call(null, config, {
      errorOnUnusedImage: false
      errorOnUnusedConfig: false
      passThroughUnused: true
    })
    .pipe gulp.dest("#{dest.images}r/")
