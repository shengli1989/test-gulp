# Global variables
require './gulp/aliases'

# better gulp.src for error handling
_gulpsrc = gulp.src

gulp.src = ->
  _gulpsrc.apply(gulp, arguments)
    .pipe $.plumber
      errorHandler: (err) ->
        logger.alert err.message

# Load sub tasks
require('require-dir')('./gulp/tasks', {recurse: true})

# Top-level tasks
run = require 'run-sequence'

gulp
  .task 'images',  (cb) -> run(['images:sketch', 'images:copy'], 'images:resize', 'images:svg-sprites', cb)
  .task 'compile', (cb) -> run('compile:variables', ['compile:jade', 'compile:sass', 'compile:coffee'], cb)
  .task 'minify',  (cb) -> run(['minify:html', 'minify:css', 'minify:js'], cb)

gulp
  .task 'default', (cb) -> run('clean', 'images', 'compile', 'dev-server', cb)
  .task 'build',   (cb) -> run('clean', 'images', 'compile', 'minify', 'sitemap', cb)
