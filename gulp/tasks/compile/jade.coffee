{ basePath, src, dest, checkExistence } = G

path = require 'path'
assign = require 'lodash/assign'
getHelpers = require './jade_helpers'
glob = require 'glob'

getData = (file) ->
  pagePath = file.path.replace(src.pages, '').replace('.jade', '')
  pageLevel = pagePath.split('/').length - 1

  pageLevelString = []
  pageLevelString.push('../') for i in [0...pageLevel] by 1
  pageLevelString = pageLevelString.join('')

  specificData =
    currentPage: pagePath.replace(/\//g, '_')
    pageLevelString: pageLevelString

  return assign(specificData, getHelpers(pageLevelString))

gulp.task 'compile:jade', ->
  checkExistence("#{src.pages}**/!(_*).jade", 'jade', src.pages)

  gulp.src(["#{src.pages}**/*.jade", "!#{src.pages}**/_*.jade"])
    .pipe $.data(getData)
    .pipe $.jade({
        pretty: !argv.minify
        basedir: "#{basePath.src}/view"
      })
    .pipe gulp.dest(dest.pages)
