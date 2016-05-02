fsCSON = require 'fs-cson'

try
  config = fsCSON.readFileSync "#{G.basePath.config}dev.cson"
  $.env {vars: config}
catch err
  logger.warn(err.toString())

taskname = argv._[0]

if taskname == 'save'
  argv.env ?= 'prod'
  argv.minify ?= true
  argv.relative ?= true
  argv.archive ?= true
else
  argv.env ?= 'dev'
  argv.minify ?= false
  argv.relative ?= false
  argv.archive ?= false
