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

  gulp.watch ["#{basePath.src}**/*.jade", "#{src.config}data.yml"], -> runSequence('compile:jade', reload)
  gulp.watch "#{src.styles}**/*.{sass,scss}", ['compile:sass']
  gulp.watch "#{src.scripts}**/*", -> runSequence('compile:coffee', reload)
