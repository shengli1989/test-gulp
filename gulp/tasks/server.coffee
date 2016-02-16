{ gulp, basePath, src } = require 'gulp-config'
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

  gulp.watch "#{basePath.src}**/*.jade", -> runSequence('jade', reload)
  gulp.watch "#{basePath.src}data.yml", -> runSequence('jade', reload)
  gulp.watch "#{src.sass}**/*.{sass,scss}", ['sass']
