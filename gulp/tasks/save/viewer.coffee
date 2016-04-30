browserify = require 'browserify'
coffeeify  = require 'coffeeify'
vueify     = require 'vueify'
source     = require 'vinyl-source-stream'
buffer     = require 'vinyl-buffer'
bs         = require 'browser-sync'

runSequence = require 'run-sequence'
reload = bs.reload

fs= require 'fs'
moment = require 'moment'

root = './gulp/libs/save/viewer/'
dest = './save'

jadeOptions =
  pretty: true

vueify.compiler.applyConfig
  sass:
    indentedSyntax: true
    includePaths: [
      './node_modules/resetcss'
    ]

gulp.task 'save:viewer:jade', ->
  files = fs.readdirSync(dest).join('\n')
  re = ///
    (\d\d\d\d-\d\d-\d\d-\d\d-\d\d)- # [1] date time
    ([i|o])-                        # [2] flag
    ([a-z_]+[^-])                   # [3] branch
    (?:-([a-z_]*))?                 # [4] comment
    \n?
  ///g

  getParserData = (folder, datetime, flag, branch, comment) ->
    folder: folder.replace('\n', '') + '/index.html'
    datetime: moment(datetime, 'YYYY-MM-DD-HH-mm')
    isInternal: flag == 'i'
    isExternal: flag != 'i'
    branch: branch.replace('__', '/').replace(/_/g, '-')
    comment: comment?.replace(/_/g, ' ') || null

  archiveData = []
  while (res = re.exec(files))?
    re.lastIndex++ if res.index == re.lastIndex
    archiveData.push getParserData.apply(null, res.slice(0, 5))

  gulp.src("#{root}*.jade")
    .pipe $.data({archiveData})
    .pipe $.jade(jadeOptions)
    .pipe gulp.dest(dest)

gulp.task 'save:viewer:coffee', (cb) ->
  browserify(
      entries: ["#{root}app.coffee"]
      transform: ['coffeeify', 'vueify']
      extensions: ['.coffee']
      debug: true
    )
    .bundle()
    .on 'error', (err) ->
      logger.alert err.toString()
      @emit('end')
    .pipe source('app.coffee')
    .pipe $.rename {
        dirname: ''
        extname: '.js'
      }
    .pipe buffer()
    # .pipe $.if(argv.minify, $.uglify())
    .pipe gulp.dest(dest)

gulp.task 'save:viewer', ['save:viewer:jade', 'save:viewer:coffee'], ->
  runSequence('deploy') if argv.deploy
  bs
    server:
      baseDir: dest
      index: 'index.html'
    port: 9000
    open: false
    reloadOnRestart: true
    extensions: 'html'

  gulp.watch ["#{root}*.jade"], -> runSequence('save:viewer:jade', reload)
  gulp.watch ["#{root}*.coffee", "#{root}**/*.{vue,sass}"], -> runSequence('save:viewer:coffee', reload)
