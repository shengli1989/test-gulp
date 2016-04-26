global.gulp = require 'gulp'
global.$ = require('gulp-load-plugins')()
global.xx = (t) -> console.log(t)
global.argv = require('yargs').argv
argv.env ?= 'dev'
