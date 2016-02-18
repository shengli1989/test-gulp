{ gulp, $, basePath, src, dest, data } = require 'gulp-config'

assign = require 'lodash/assign'
helper = require './jade_helper'

gulp.task 'compile:jade', ->
  gulp.src(["#{src.pages}**/*.jade", "!#{src.pages}**/_*.jade"])
    .pipe $.plumber()
    .pipe $.jade({
        pretty: true
        data: assign(data, helper)
        basedir: "#{global.process.env.INIT_CWD}/#{basePath.src}/jade"
      })
    .pipe gulp.dest(dest.pages)
