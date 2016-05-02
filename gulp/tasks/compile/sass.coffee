{ src, dest, checkExistence } = G
bs = require 'browser-sync'

gulp.task 'compile:sass', (cb) ->
  checkExistence("#{src.styles}*.sass", 'sass', src.styles)

  options =
    assets:
      basePath: 'build/'
      loadPaths: ['assets/images/r/']
    autoprefixer:
      browsers: ['last 1 version', 'ie 10', '> 1%']
    cssGlobbing:
      extensions: ['.sass', '.scss']
    cssnano:
      discardComments: { removeAll: true }
    preprocess:
      context: { env: argv.env }
    sass:
      precision: 10
      includePaths: [
        './node_modules/normalize.css'
        './node_modules/sass-mq'
      ]

  if argv.archive
    options.assets =
      basePath: 'build/assets/'
      loadPaths: ['images/r/']

  options.postcss = [
    require('autoprefixer')(options.autoprefixer)
  ]

  try
    fsCSON.readFileSync "#{basePath.config}image-breakpoints.cson"
    options.postcss.push(require('postcss-assets')(options.assets))
  catch err

  gulp.src("#{src.styles}*.sass")
    .pipe $.if(!argv.minify, $.sourcemaps.init())
    .pipe $.cssGlobbing(options.cssGlobbing)
    .pipe $.preprocess(options.preprocess)
    .pipe $.sass.sync(options.sass)
    .pipe $.postcss(options.postcss)
    .pipe $.if(!argv.minify, $.sourcemaps.write('.'))
    .pipe $.if(argv.minify, $.cssnano(options.cssnano))
    .pipe $.if(argv.archive, $.replace(/(url\(['|"]?)(\/)/g, "$1..$2"))
    .pipe gulp.dest(dest.styles)
    .pipe $.filter(['**/*.css'])
    .pipe bs.stream()
