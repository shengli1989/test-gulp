global.gulp = require 'gulp'
global.$ = require('gulp-load-plugins')()
global.xx = (t) -> console.log(t)

fs = require 'fs'
yaml = require 'js-yaml'
{ rootPath, basePath, src, dest, resizedImagesFolder } = require './config/path'

readYml = (dir, fileName) ->
  filePath = "#{dir}#{fileName}.yml"
  if fs.existsSync(filePath)
    yaml.safeLoad fs.readFileSync(filePath, 'utf-8')
  else
    false

readConfig = (fileName) -> readYml(basePath.config, fileName)
readData = (fileName) -> readYml(src.data, fileName)

global.G = { rootPath, basePath, src, dest, resizedImagesFolder, readConfig, readData }
