{ basePath, src } = G
bs = require 'browser-sync'
runSequence = require 'run-sequence'
reload = bs.reload

gulp.task 'dev-server', ->
  bs
    server:
      baseDir: basePath.dest
      index: 'index.html'
    port: 9000
    open: false
    reloadOnRestart: true
    extensions: 'html'

  gulp.watch ["#{basePath.src}**/*.jade", "#{src.data}*.yml"], -> runSequence('compile:jade', reload)
  gulp.watch "#{src.styles}**/*.{sass,scss}", ['compile:sass']
  gulp.watch "#{src.scripts}**/*", -> runSequence('compile:coffee', reload)
  gulp.watch "#{basePath.config}shared.yml", -> runSequence('compile', reload)

  gulp.watch "#{src.sketch}*.sketch", -> runSequence('images:sketch', 'images:resize', reload)
  gulp.watch "#{basePath.config}resize-image.coffee", -> runSequence('images:resize', reload)
