{ gulp, $, basePath, src, dest } = require 'gulp-config'
fs = require 'fs'
bs = require 'browser-sync'
jsonSass = require 'json-sass'
source = require 'vinyl-source-stream'
del = require 'del'

gulp.task 'sass-config:source', ->
  gulp.src "#{basePath.src}shared-config.yml"
    .pipe $.yaml({ safe: true })
    .pipe gulp.dest('./.tmp/')

gulp.task 'sass-config:generate', ['sass-config:source'], ->
  jsonFile = "./.tmp/shared-config.json"

  fs.createReadStream(jsonFile)
    .pipe jsonSass(
      prefix:
        """// Generated from shared-config.json, DO NOT modify this directly.

        $theme: """
    )
    .pipe source(jsonFile)
    .pipe $.rename('_shared-config.scss')
    .pipe gulp.dest(src.styles)

gulp.task 'compile:sass', ['sass-config:generate'], ->
  del './.tmp'

  gulp.src("#{src.styles}*.sass")
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
    .pipe $.cssGlobbing {
      extensions: ['.sass', '.scss']
    }
    .pipe $.sass.sync({
      includePaths: [
        './node_modules/normalize.css'
      ]
    })
    .pipe $.postcss([
      require('autoprefixer')({browsers: ['last 1 version', 'ie 10', '> 1%']}),
    ])
    .pipe $.sourcemaps.write('.')
    .pipe gulp.dest(dest.styles)
    .pipe bs.stream()
