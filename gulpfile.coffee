gulp = require 'gulp'
runSequence = require 'run-sequence'
require('require-dir')('./gulp', {recurse: true})

gulp.task 'compile', (cb) ->
  runSequence(['jade', 'sass', 'coffee'], cb)

gulp.task 'default', (cb) ->
  runSequence('clean', 'compile', 'dev-server', cb)
