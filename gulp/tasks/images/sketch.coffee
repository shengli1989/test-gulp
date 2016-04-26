{ src, dest, checkExistence } = G
which = require('npm-which')(__dirname)
glob = require 'glob'


gulp.task 'images:sketch', ->
  # to skip this task for windows user
  try
    which.sync('sketchtool')
  catch err
    return logger.warn(err)

  checkExistence "#{src.sketch}*.sketch", 'sketch', src.sketch

  gulp.src "#{src.sketch}*.sketch"
    .pipe $.sketch
      export: 'slices'
    .pipe gulp.dest(dest.images)
