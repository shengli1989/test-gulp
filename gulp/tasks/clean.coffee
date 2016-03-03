{ basePath } = G
del = require 'del'

gulp.task 'clean', ->
  del(basePath.dest)
