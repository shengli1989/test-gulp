{ basePath, src } = G
bs = require 'browser-sync'
rs = require 'run-sequence'
reload = bs.reload

kexec = require 'kexec'

gulp.task 'gulp-reload', ->
  logger.info('gulpfile changed')
  command = [argv._.join(' ')]
  for arg, setting of argv
    command.push("--#{arg}", setting) if !(arg in ['$0', '_'])
  command.push('--restart', 'true') if !argv.restart

  kexec('gulp', command)

gulp.task 'dev-server', (cb) ->
  bsOptions =
    server:
      baseDir: basePath.dest
      index: 'index.html'
    port: 9000
    open: true
    reloadOnRestart: true
    extensions: 'html'

  bsOptions.open = false if argv.restart

  bs bsOptions

  [
    ["#{basePath.src}**/*.jade", "#{src.data}**/*.{yml,jade}"], ['compile:jade', reload]
    "#{src.styles}**/*.{sass,scss}",                            ['compile:sass']
    "#{src.scripts}**/*",                                       ['compile:coffee', reload]
    "#{basePath.config}shared.yml",                             ['compile', reload]
    './gulp/libs/images/svg-sprites/*.handlebars',              ['images:svg-sprites']
    "#{src.sketch}*.sketch",                                    ['images:sketch', 'images:resize', 'images:svg-sprites', reload]
    "#{basePath.config}image-breakpoints.coffee",               ['images:resize', reload]
    ['./gulpfile.coffee', './gulp/**/*.coffee'],                ['gulp-reload']
  ].forEach (files, i, arr) ->
    $.watch(files, -> rs.apply(null, arr[i+1])) if i % 2 == 0

  cb()
