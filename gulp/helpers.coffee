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

module.exports = { readConfig, readData }
