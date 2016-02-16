{ gulp, $, src, dest } = require 'gulp-config'
bs = require 'browser-sync'

gulp.task 'sass', ->
  gulp.src("#{src.sass}*")
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
    .pipe $.sass.sync()
    .pipe $.autoprefixer()
    .pipe $.sourcemaps.write('.')
    .pipe gulp.dest(dest.style)
    .pipe bs.stream()
