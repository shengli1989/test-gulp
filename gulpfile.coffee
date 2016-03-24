run = require 'run-sequence'

# Global variables
require './gulp/aliases'
{ rootPath, basePath, src, dest, resizedImagesFolder } = require './gulp/paths'
{ readConfig, readData } = require './gulp/helpers'

global.G = { rootPath, basePath, src, dest, resizedImagesFolder, readConfig, readData }

# Load sub tasks
require('require-dir')('./gulp/tasks', {recurse: true})


# Top-level tasks
gulp
  .task 'images',  (cb) -> run(['images:sketch', 'images:copy'], 'images:resize', cb)
  .task 'compile', (cb) -> run('compile:variables', ['compile:jade', 'compile:sass', 'compile:coffee'], cb)
  .task 'minify',  (cb) -> run(['minify:html', 'minify:css', 'minify:js'], cb)

gulp
  .task 'default', (cb) -> run('clean', 'images', 'compile', 'dev-server', cb)
  .task 'build',   (cb) -> run('clean', 'images', 'compile', 'minify', 'sitemap', cb)
