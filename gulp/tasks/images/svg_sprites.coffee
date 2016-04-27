{ src, dest } = G

config =
  mode:
    symbol:
      dest: dest.images
      sprite: 'sprite.svg'
      render:
        demo:
          template: './gulp/tmpl/symbol-demo.jade.handlebars'
        inline:
          template: './gulp/tmpl/symbol-inline.jade.handlebars'
        mixin:
          template: './gulp/tmpl/symbol-mixin.jade.handlebars'
  svg:
    xmlDeclaration: false
    doctypeDeclaration: false

gulp.task 'images:svg-sprites', (cb) ->
  gulp.src("#{src.svgSprites}**/*.svg")
    .pipe $.svgSprite(config)
    .on 'error', (err) ->
      $.util.log $.util.colors.red(err.toString())
      cb()
    .pipe $.if(/[.]demo$/, $.rename('src/view/pages/demo/symbol.jade'))
    .pipe $.if(/[.]mixin$/, $.rename('src/view/mixin/_icon.jade'))
    .pipe $.if(/[.]inline$/, $.rename('src/view/layouts/shared/_svg-sprites.jade'))
    .pipe gulp.dest('.')
