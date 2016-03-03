{ src, dest, resizedImagesFolder } = G
bs = require 'browser-sync'

gulp.task 'compile:sass', (done) ->
  gulp.src("#{src.styles}*.sass")
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
    .pipe $.cssGlobbing {
      extensions: ['.sass', '.scss']
    }
    .pipe $.sass.sync({
      precision: 10
      includePaths: [
        './node_modules/normalize.css'
        './node_modules/sass-mq'
      ]
    })
    .pipe $.postcss([
      require('autoprefixer')({ browsers: ['last 1 version', 'ie 10', '> 1%'] })
      require('postcss-assets')({ basePath: 'build/', loadPaths: [resizedImagesFolder] })
    ])
    .on 'error', (err) ->
      $.util.log $.util.colors.red(err.toString())
      done()
      bs.stream()
    .pipe $.sourcemaps.write('.')
    .pipe gulp.dest(dest.styles)
    .pipe $.filter(['**/*.css'])
    .pipe bs.stream()
