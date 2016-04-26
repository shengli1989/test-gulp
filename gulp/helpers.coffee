{ basePath, src } = G

fs = require 'fs'
yaml = require 'js-yaml'
glob = require 'glob'
assign = require 'lodash/assign'

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

assign(G, {readConfig, readData, checkExistence})
