{ basePath, src, dest, checkExistence } = G

path = require 'path'
assign = require 'lodash/assign'
helpers = require './jade_helpers'
glob = require 'glob'

getData = (file) ->
  relativePagePath = file.path.replace(src.pages, '').replace('.jade', '')
  specificData =
    currentPage: relativePagePath.replace(/\//g, '_')
  return assign(specificData, helpers)

gulp.task 'compile:jade', ->
  checkExistence("#{src.pages}**/!(_*).jade", 'jade', src.pages)

  gulp.src(["#{src.pages}**/*.jade", "!#{src.pages}**/_*.jade"])
    .pipe $.data(getData)
    .pipe $.jade({
        pretty: !argv.minify
        basedir: "#{basePath.src}/view"
      })
    .pipe gulp.dest(dest.pages)
