{ basePath, src, dest, checkExistence } = G

path = require 'path'
assign = require 'lodash/assign'
getHelpers = require './jade_helpers'
glob = require 'glob'
es = require 'event-stream'
fs = require 'fs'

jadeOptions =
  pretty: !argv.minify
  basedir: "#{basePath.src}/view"

getData = (entry) ->
  pagePath = entry.replace(src.pages, '').replace('.jade', '')
  pageLevel = pagePath.split('/').length - 1

  pageLevelString = []
  pageLevelString.push('../') for i in [0...pageLevel] by 1
  pageLevelString = pageLevelString.join('')

  specificData =
    currentPage: pagePath.replace(/\//g, '_')
    pageLevelString: pageLevelString

  return assign(specificData, getHelpers(pageLevelString))

rootToRelativeReplacerFn = (pageLevelString) ->
  (match, href) ->
    href = href.replace('/', '')
    index = ''

    try
      fs.accessSync("#{src.pages}#{href}.jade", fs.F_OK)
    catch err
      index = if href.length then '/index' else 'index'

    "a href=\"#{pageLevelString}#{href}#{index}.html\""

gulp.task 'compile:jade', (cb) ->
  pat = "#{src.pages}**/!(_*).jade"
  checkExistence(pat, 'jade', src.pages)

  glob pat, (err, files) ->
    return cb() if !files.length

    tasks = files.map (entry) ->
      pathClips = path.dirname(entry).split('pages/')
      page = pathClips[1] || ''
      data = getData(entry)
      replacer = rootToRelativeReplacerFn(data.pageLevelString)

      gulp.src(entry)
        .pipe $.data(data)
        .pipe $.jade(jadeOptions)
        .pipe $.if(argv.archive, $.replace(/a href="(\/[^\/\"\'][^\"\']*|\/)"/g, replacer))
        .pipe gulp.dest(dest.pages + page)

    es.merge(tasks).on('end', cb)
