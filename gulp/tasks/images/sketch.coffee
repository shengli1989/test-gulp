{ src, dest } = G
which = require('npm-which')(__dirname)

gulp.task 'images:sketch', ->
  # to skip this task for windows user
  try
    which.sync('sketchtool')
  catch error
    return $.util.log(error)

  gulp.src "#{src.sketch}*.sketch"
    .pipe $.sketch
      export: 'slices'
    .pipe gulp.dest(dest.images)
