global.gulp = require 'gulp'
global.$ = require('gulp-load-plugins')()
global.xx = (t) -> console.log(t)

fs = require 'fs'
yaml = require 'js-yaml'

rootPath = global.process.env.PWD

basePath =
  root: rootPath
  src: "#{rootPath}/src/"
  dest: "#{rootPath}/build/"
  config: "#{rootPath}/config/"

src =
  styles: "#{basePath.src}sass/"
  scripts: "#{basePath.src}scripts/"
  sketch: "#{basePath.src}sketch/"
  pages: "#{basePath.src}jade/pages/"
  images: "#{basePath.src}images/"
  data: "#{basePath.src}data/"

dest =
  styles: "#{basePath.dest}assets/stylesheets/"
  scripts: "#{basePath.dest}assets/javascripts/"
  images: "#{basePath.dest}assets/images/"
  pages: "#{basePath.dest}"

resizedImagesFolder = 'assets/images/r/'

readYml = (dir, fileName) ->
  filePath = "#{dir}#{fileName}.yml"
  if fs.existsSync(filePath)
    yaml.safeLoad fs.readFileSync(filePath, 'utf-8')
  else
    false

readConfig = (fileName) -> readYml(basePath.config, fileName)
readData = (fileName) -> readYml(src.data, fileName)

global.G = { basePath, src, dest, resizedImagesFolder, readConfig, readData }
