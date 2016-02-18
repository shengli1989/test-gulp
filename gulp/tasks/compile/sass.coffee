{ gulp, $, src, dest } = require 'gulp-config'
bs = require 'browser-sync'

gulp.task 'compile:sass', ->
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
