'use strict'

import gulp from 'gulp'
import gulpLoadPlugins from 'gulp-load-plugins'

let $ = gulpLoadPlugins()

const dirs = {
  src: 'src',
  dest: 'build'
}

const paths = {
  src: `${dirs.src}/app.scss`,
  dest: `${dirs.dest}/styles/`
}

gulp.task('styles', () => {
  return gulp.src(paths.src)
    .pipe($.sourcemaps.init())
    .pipe($.sass.sync())
    .pipe($.autoprefixer())
    .pipe($.sourcemaps.write('.'))
    .pipe(gulp.dest(paths.dest))
})
