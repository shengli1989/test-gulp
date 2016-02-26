{ gulp, $, basePath, src, dest, readConfig } = require 'gulp-config'

assign = require 'lodash/assign'
helper = require './jade_helper'

gulp.task 'compile:jade', ->
  data = readConfig('data')

  gulp.src(["#{src.pages}**/*.jade", "!#{src.pages}**/_*.jade"])
    .pipe $.plumber()
    .pipe $.jade({
        pretty: true
        data: assign(data, helper)
        basedir: "#{basePath.root}/#{basePath.src}/jade"
      })
    .pipe gulp.dest(dest.pages)
