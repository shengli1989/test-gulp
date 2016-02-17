{ gulp, $, basePath, src, dest } = require 'gulp-config'

assign = require 'lodash/assign'
fs = require 'fs'
yaml = require 'js-yaml'
helper = require './jade_helper'


gulp.task 'jade', ->
  data = yaml.safeLoad(fs.readFileSync("#{basePath.src}data.yml", 'utf-8'))
  data = assign(data, helper)

  gulp.src(["#{src.page}**/*.jade", "!#{src.page}**/_*.jade"])
    .pipe $.plumber()
    .pipe $.jade({
        pretty: true
        data: data
        basedir: "#{global.process.env.INIT_CWD}/#{basePath.src}/jade"
      })
    .pipe gulp.dest(dest.page)
