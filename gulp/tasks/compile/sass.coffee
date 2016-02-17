{ gulp, $, src, dest } = require 'gulp-config'
bs = require 'browser-sync'

gulp.task 'sass', ->
  gulp.src("#{src.sass}*.sass")
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
    .pipe $.autoprefixer()
    .pipe $.sourcemaps.write('.')
    .pipe gulp.dest(dest.style)
    .pipe bs.stream()
