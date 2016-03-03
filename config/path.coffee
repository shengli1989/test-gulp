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

module.exports = { rootPath, basePath, src, dest, resizedImagesFolder }
