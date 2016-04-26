{ basePath, src } = require './paths'

fs = require 'fs'
yaml = require 'js-yaml'
glob = require 'glob'

logger =
  info: (msg) -> $.util.log($.util.colors.blue("[INFO] #{msg}"))
  warn: (msg) -> $.util.log($.util.colors.yellow("[WARN] #{msg}"))
  alert: (msg) -> $.util.log($.util.colors.red("[ALERT] #{msg}"))

readYml = (dir, fileName, cb) ->
  filePath = "#{dir}#{fileName}.yml"

  try
    fs.accessSync(filePath, fs.F_OK)
    yaml.safeLoad fs.readFileSync(filePath, 'utf-8')
  catch err
    logger.alert "#{filePath} not found"
    cb(err) if cb?

readConfig = (fileName, cb) -> readYml(basePath.config, fileName, cb)
readData = (fileName) -> readYml(src.data, fileName)

checkExistence = (pattern, task, directory) ->
  glob pattern, (err, files) ->
    if !files.length
      logger.warn "#{task}: no files matches under #{directory}"

module.exports = { readConfig, readData, logger, checkExistence }
