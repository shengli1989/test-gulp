assign = require 'lodash/assign'

rootPath = global.process.env.PWD

basePath =
  root: rootPath
  src: "#{rootPath}/src/"
  dest: "#{rootPath}/build/"
  config: "#{rootPath}/config/"
  archive: "#{rootPath}/save/"
  libs: "#{rootPath}/gulp/libs/"
  data: "#{rootPath}/data/"

src =
  styles: "#{basePath.src}sass/"
  scripts: "#{basePath.src}scripts/"
  sketch: "#{basePath.src}sketch/"
  pages: "#{basePath.src}view/pages/"
  images: "#{basePath.src}images/"
  svgSprites: "#{basePath.src}svg_sprites/"

dest =
  styles: "#{basePath.dest}assets/stylesheets/"
  scripts: "#{basePath.dest}assets/javascripts/"
  images: "#{basePath.dest}assets/images/"
  pages: "#{basePath.dest}"

resizedImagesFolder = 'assets/images/r/'
spritesUrl = 'assets/images/sprite.svg'

getPathFn = (folder, extension) ->
  (name, pageLevelString) ->
    if name.indexOf('//') < 0
      rel = if argv.relative then pageLevelString else '/'
      path = "#{rel}#{folder}#{name}"
    else
      path = name
    path += extension if name.indexOf(extension) < 0
    path

getImageUrl = (name, pageLevelString) ->
  rel = if argv.relative then pageLevelString else '/'
  "#{rel}#{resizedImagesFolder}#{name}"

getCssPath = getPathFn('assets/stylesheets/', '.css')
getJsPath = getPathFn('assets/javascripts/', '.js')

assign(G, {rootPath, basePath, src, dest, spritesUrl, getImageUrl, getCssPath, getJsPath})
