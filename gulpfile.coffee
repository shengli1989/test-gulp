gulp = require 'gulp'
runSequence = require 'run-sequence'
require('require-dir')('./gulp', {recurse: true})

gulp.task 'default', (cb) ->
  runSequence('clean', ['jade', 'sass'], 'dev-server', cb)
