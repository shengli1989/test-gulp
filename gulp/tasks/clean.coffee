{ gulp, basePath } = require 'gulp-config'
del = require 'del'

gulp.task 'clean', ->
  del(basePath.dest)
