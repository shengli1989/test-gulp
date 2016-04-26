run = require 'run-sequence'
env = require('yargs').argv.env || 'dev'

# Global variables
require './gulp/aliases'
{ rootPath, basePath, src, dest, resizedImagesFolder, spritesUrl } = require './gulp/paths'
{ readConfig, readData, logger } = require './gulp/helpers'

global.G = { env, rootPath, basePath, src, dest, resizedImagesFolder, spritesUrl, readConfig, readData, logger }

logger.info "current environment: #{env}"

# Load sub tasks
require('require-dir')('./gulp/tasks', {recurse: true})


# Top-level tasks
gulp
  .task 'images',  (cb) -> run(['images:sketch', 'images:copy'], 'images:resize', 'images:svg-sprites', cb)
  .task 'compile', (cb) -> run('compile:variables', ['compile:jade', 'compile:sass', 'compile:coffee'], cb)
  .task 'minify',  (cb) -> run(['minify:html', 'minify:css', 'minify:js'], cb)

gulp
  .task 'default', (cb) -> run('clean', 'images', 'compile', 'dev-server', cb)
  .task 'build',   (cb) -> run('clean', 'images', 'compile', 'minify', 'sitemap', cb)
