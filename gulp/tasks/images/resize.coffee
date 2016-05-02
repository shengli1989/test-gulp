{ basePath, src, dest } = G

fsCson = require 'fs-cson'

gulp.task 'images:resize', (cb) ->
  fsCson.readFile "#{basePath.config}image-breakpoints.cson", (err, config) ->
    if err
      logger.warn err.toString()
      cb()
    else
      gulp.src(["#{dest.images}**/*", "!#{dest.images}{r,r/**/*}"])
        .pipe $.responsive.call(null, config, {
          errorOnUnusedImage: false
          errorOnUnusedConfig: false
          passThroughUnused: true
        })
        .pipe gulp.dest("#{dest.images}r/")
        .on 'end', cb
