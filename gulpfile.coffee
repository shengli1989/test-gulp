gulp = require 'gulp'
run = require 'run-sequence'

# Load sub tasks
require('require-dir')('./gulp', {recurse: true})

# Top-level tasks
gulp
  .task 'compile', (cb) -> run('compile:variables', ['compile:jade', 'compile:sass', 'compile:coffee'], cb)
  .task 'minify',  (cb) -> run(['minify:html', 'minify:css', 'minify:js'], cb)
  .task 'default', (cb) -> run('clean', 'compile', 'dev-server', cb)
  .task 'build',   (cb) -> run('clean', 'compile', 'minify', 'sitemap', cb)
