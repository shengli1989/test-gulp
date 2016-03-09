{ basePath, src, dest } = G

path = require 'path'
assign = require 'lodash/assign'
helpers = require './jade_helpers'

getData = (file) ->
  relativePagePath = file.path.replace(src.pages, '').replace('.jade', '')
  specificData = 
    currentPage: relativePagePath.replace(/\//g, '_')
  assign(specificData, helpers)

gulp.task 'compile:jade', ->
  gulp.src(["#{src.pages}**/*.jade", "!#{src.pages}**/_*.jade"])
    .pipe $.plumber()
    .pipe $.data(getData)
    .pipe $.jade({
        pretty: true
        basedir: "#{basePath.src}/jade"
      })
    .pipe gulp.dest(dest.pages)
