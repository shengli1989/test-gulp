assign = require 'lodash/assign'

rootPath = global.process.env.PWD

basePath =
  root: rootPath
  src: "#{rootPath}/src/"
  dest: "#{rootPath}/build/"
  config: "#{rootPath}/config/"
  archive: "#{rootPath}/save/"

src =
  styles: "#{basePath.src}sass/"
  scripts: "#{basePath.src}scripts/"
  sketch: "#{basePath.src}sketch/"
  pages: "#{basePath.src}view/pages/"
  data: "#{basePath.src}view/data/"
  images: "#{basePath.src}images/"
  svgSprites: "#{basePath.src}svg_sprites/"

dest =
  styles: "#{basePath.dest}assets/stylesheets/"
  scripts: "#{basePath.dest}assets/javascripts/"
  images: "#{basePath.dest}assets/images/"
  pages: "#{basePath.dest}"

resizedImagesFolder = '/assets/images/r/'
spritesUrl = '/assets/images/sprite.svg'

assign(G, {rootPath, basePath, src, dest, resizedImagesFolder, spritesUrl})
