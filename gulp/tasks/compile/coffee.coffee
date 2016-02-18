{ $, gulp, basePath, src, dest } = require 'gulp-config'

browserify = require 'browserify'
coffeeify  = require 'coffeeify'
source     = require 'vinyl-source-stream'
glob       = require 'glob'
es         = require 'event-stream'

gulp.task 'coffee', (cb) ->
  glob "#{src.scripts}!(_*).coffee", (err, files) ->
    cb(err) if err

    tasks = files.map (entry) ->
      browserify({ entries: [entry], transform: ['coffeeify'], extensions: ['.coffee'] })
        .bundle()
        .pipe source(entry)
        .pipe(
          $.rename {
            dirname: ''
            extname: '.js'
          }
        )
        .pipe gulp.dest(dest.scripts)

    es.merge(tasks).on('end', cb)
