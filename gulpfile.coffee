# Global variables
require './gulp/aliases'

# better gulp.src for error handling
_gulpsrc = gulp.src

gulp.src = ->
  _gulpsrc.apply(gulp, arguments)
    .pipe $.plumber
      errorHandler: G.onError

# Load sub tasks
require('require-dir')('./gulp/tasks', {recurse: true})

# Top-level tasks
run = require 'run-sequence'

gulp
  .task 'images',  (cb) -> run(['images:sketch', 'images:copy'], 'images:resize', 'images:svg-sprites', cb)
  .task 'compile', (cb) -> run('compile:variables', ['compile:jade', 'compile:sass', 'compile:coffee'], cb)
  .task 'main',    (cb) -> run('clean', 'images', 'compile', cb)

gulp
  .task 'default', (cb) -> run('main', 'dev-server', cb)
  .task 'save',    (cb) -> run('main', 'save:archive', 'save:viewer', cb)
  .task 'deploy',  (cb) -> run('gh-page', cb)

logger.info "current environment: #{argv.env}"
