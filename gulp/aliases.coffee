global.G = {}
global.gulp = require 'gulp'
global.$ = require('gulp-load-plugins')()
global.xx = (t) -> console.log(t)
global.argv = require('yargs').argv
global.logger =
  info: (msg) -> $.util.log($.util.colors.blue("[INFO] #{msg}"))
  warn: (msg) -> $.util.log($.util.colors.yellow("[WARN] #{msg}"))
  alert: (msg) -> $.util.log($.util.colors.red("[ALERT] #{msg}"))

argv.env ?= 'dev'
argv.minify ?= false
argv.relative ?= false
argv.archive ?= false

logger.info "current environment: #{argv.env}"

if argv._[0] == 'save'
  argv.env = 'prod'
  argv.minify = true
  argv.relative = true
  argv.archive = true

require './paths'
require './helpers'
