{ src, dest, checkExistence } = G
bs = require 'browser-sync'

gulp.task 'compile:sass', (done) ->
  checkExistence("#{src.styles}*.sass", 'sass', src.styles)

  gulp.src("#{src.styles}*.sass")
    .pipe $.plumber()
    .pipe $.if(!argv.minify, $.sourcemaps.init())
    .pipe $.cssGlobbing {
      extensions: ['.sass', '.scss']
    }
    .pipe $.preprocess({context: { env: argv.env }})
    .pipe $.sass.sync({
      precision: 10
      includePaths: [
        './node_modules/normalize.css'
        './node_modules/sass-mq'
      ]
    })
    .pipe $.postcss([
      require('autoprefixer')({ browsers: ['last 1 version', 'ie 10', '> 1%'] })
      require('postcss-assets')({ basePath: 'build/assets/', loadPaths: ['images/r/'] })
    ])
    .on 'error', (err) ->
      logger.alert err.toString()
      done()
      bs.stream()
    .pipe $.if(!argv.minify, $.sourcemaps.write('.'))
    .pipe $.if(argv.minify, $.cssnano({discardComments: {removeAll: true}}))
    .pipe $.if(argv.archive, $.replace("url('/", "url('../"))
    .pipe gulp.dest(dest.styles)
    .pipe $.filter(['**/*.css'])
    .pipe bs.stream()
