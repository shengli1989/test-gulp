gulp = require 'gulp'
runSequence = require 'run-sequence'
require('require-dir')('./gulp', {recurse: true})

gulp.task 'compile', (cb) ->
  runSequence(['compile:jade', 'compile:sass', 'compile:coffee'], cb)

gulp.task 'minify', (cb) ->
  runSequence(['minify:html', 'minify:css', 'minify:js'], cb)

gulp.task 'default', (cb) ->
  runSequence('clean', 'compile', 'dev-server', cb)

gulp.task 'build', (cb) ->
  runSequence('clean', 'compile', 'minify', cb)
