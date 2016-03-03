{ basePath, src } = G

fs = require 'fs'
jsonSass = require 'json-sass'
source = require 'vinyl-source-stream'

gulp.task 'compile:variables_transform_source', ->
  gulp.src "#{basePath.config}shared.yml"
    .pipe $.yaml({ safe: true })
    .pipe gulp.dest('./.tmp/')

gulp.task 'compile:variables', ['compile:variables_transform_source'], ->
  jsonFile = "./.tmp/shared.json"

  fs.createReadStream(jsonFile)
    .pipe jsonSass(
      prefix:
        """// Generated from shared-config.json, DO NOT modify this directly.

        $theme: """
    )
    .pipe source(jsonFile)
    .pipe $.rename('_shared-config.scss')
    .pipe gulp.dest(src.styles)

# del = require 'del'
# del './.tmp'
