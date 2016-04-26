{ src, dest } = G

config =
  mode:
    symbol:
      dest: dest.images
      sprite: 'sprite.svg'
      example:
        template: './gulp/tmpl/symbol-demo.jade.handlebars'
  svg:
    xmlDeclaration: false
    doctypeDeclaration: false

gulp.task 'images:svg-sprites', (done) ->
  gulp.src("#{src.svgSprites}**/*.svg")
    .pipe $.svgSprite(config)
    .on 'error', (err) ->
      $.util.log $.util.colors.red(err.toString())
      done()
    .pipe $.if(/[.]html$/, $.rename("src/view/pages/demo/symbol.jade"))
    .pipe gulp.dest('.')
