{ basePath, src } = G
bs = require 'browser-sync'
runSequence = require 'run-sequence'
reload = bs.reload

spawn = require('child_process').spawn

gulp.task 'gulp-reload', ->
  logger.info('gulpfile changed')
  spawn('gulp', ['default', '--env', argv.env], {stdio: 'inherit'})
  process.exit()

gulp.task 'dev-server', ->
  bs
    server:
      baseDir: basePath.dest
      index: 'index.html'
    port: 9000
    open: false
    reloadOnRestart: true
    extensions: 'html'

  gulp.watch ["#{basePath.src}**/*.jade", "#{src.data}**/*.{yml,jade}"], -> runSequence('compile:jade', reload)
  gulp.watch "#{src.styles}**/*.{sass,scss}", ['compile:sass']
  gulp.watch "#{src.scripts}**/*", -> runSequence('compile:coffee', reload)
  gulp.watch "#{basePath.config}shared.yml", -> runSequence('compile', reload)
  gulp.watch './gulp/libs/images/svg-sprites/*.handlebars', ['images:svg-sprites']

  gulp.watch "#{src.sketch}*.sketch", -> runSequence('images:sketch', 'images:resize', 'images:svg-sprites', reload)
  gulp.watch "#{basePath.config}image-breakpoints.coffee", -> runSequence('images:resize', reload)

  gulp.watch(['./gulpfile.coffee', './gulp/**/*.coffee'], ['gulp-reload'])
