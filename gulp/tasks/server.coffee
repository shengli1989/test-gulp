{ basePath, src } = G
bs = require 'browser-sync'
rs = require 'run-sequence'
reload = bs.reload

spawn = require('child_process').spawn

gulp.task 'gulp-reload', ->
  logger.info('gulpfile changed')
  spawn('gulp', ['default', '--env', argv.env], {stdio: 'inherit'})
  process.exit()

gulp.task 'dev-server', (cb) ->
  bs
    server:
      baseDir: basePath.dest
      index: 'index.html'
    port: 9000
    open: false
    reloadOnRestart: true
    extensions: 'html'

  $.watch ["#{basePath.src}**/*.jade", "#{src.data}**/*.{yml,jade}"], -> rs('compile:jade', reload)
  $.watch "#{src.styles}**/*.{sass,scss}", -> rs('compile:sass')
  $.watch "#{src.scripts}**/*", -> rs('compile:coffee', reload)
  $.watch "#{basePath.config}shared.yml", -> rs('compile', reload)
  $.watch './gulp/libs/images/svg-sprites/*.handlebars', ['images:svg-sprites']

  $.watch "#{src.sketch}*.sketch", -> rs('images:sketch', 'images:resize', 'images:svg-sprites', reload)
  $.watch "#{basePath.config}image-breakpoints.coffee", -> rs('images:resize', reload)

  $.watch ['./gulpfile.coffee', './gulp/**/*.coffee'], -> rs('gulp-reload')
  cb()
