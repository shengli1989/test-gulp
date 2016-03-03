{ gulp, $, basePath, src, dest, readData } = require 'gulp-config'

path = require 'path'
assign = require 'lodash/assign'
helper = require './jade_helper'

getData = (file) ->
  relativePagePath = file.path.replace(src.pages, '').replace('.jade', '')

  globalData = readData('global')
  specificData = readData(relativePagePath) || {}
  specificData.currentPage = relativePagePath.replace(/\//g, '_')
  assign(globalData, specificData, helper)

gulp.task 'compile:jade', ->
  gulp.src(["#{src.pages}**/*.jade", "!#{src.pages}**/_*.jade"])
    .pipe $.plumber()
    .pipe $.data(getData)
    .pipe $.jade({
        pretty: true
        basedir: "#{basePath.src}/jade"
      })
    .pipe gulp.dest(dest.pages)
