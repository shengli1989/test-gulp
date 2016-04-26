{ basePath, src } = require './paths'

fs = require 'fs'
yaml = require 'js-yaml'

readYml = (dir, fileName) ->
  filePath = "#{dir}#{fileName}.yml"
  if fs.existsSync(filePath)
    yaml.safeLoad fs.readFileSync(filePath, 'utf-8')
  else
    false

readConfig = (fileName) -> readYml(basePath.config, fileName)
readData = (fileName) -> readYml(src.data, fileName)

logger =
  info: (msg) -> $.util.log($.util.colors.blue("[INFO] #{msg}"))
  warn: (msg) -> $.util.log($.util.colors.red("[WARN] #{msg}"))

module.exports = { readConfig, readData, logger }
