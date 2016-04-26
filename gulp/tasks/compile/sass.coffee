{ src, dest, resizedImagesFolder, checkExistence, logger } = G
bs = require 'browser-sync'

gulp.task 'compile:sass', (done) ->
  checkExistence("#{src.styles}*.sass", 'sass', src.styles)

  gulp.src("#{src.styles}*.sass")
    .pipe $.plumber()
    .pipe $.sourcemaps.init()
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
      require('postcss-assets')({ basePath: 'build/', loadPaths: [resizedImagesFolder.replace('/', '')] })
    ])
    .on 'error', (err) ->
      logger.alert err.toString()
      done()
      bs.stream()
    .pipe $.sourcemaps.write('.')
    .pipe gulp.dest(dest.styles)
    .pipe $.filter(['**/*.css'])
    .pipe bs.stream()
