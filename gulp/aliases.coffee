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
logger.info "current environment: #{argv.env}"

require './paths'
require './helpers'
