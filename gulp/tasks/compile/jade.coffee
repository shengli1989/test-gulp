{ gulp, $, basePath, src, dest } = require 'gulp-config'

fs = require 'fs'
yaml = require 'js-yaml'

gulp.task 'jade', ->
  data = yaml.safeLoad(fs.readFileSync("#{basePath.src}data.yml", 'utf-8'))
  data.test = (int) -> "hello #{int}"

  gulp.src(["#{src.page}**/*.jade", "!#{src.page}**/_*.jade"])
    .pipe $.plumber()
    .pipe $.jade({
        pretty: true
        data: data
        basedir: "#{global.process.env.INIT_CWD}/#{basePath.src}/jade"
      })
    .pipe gulp.dest(dest.page)
