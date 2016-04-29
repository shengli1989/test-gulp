moment = require 'moment'
git = require 'git-rev'
del = require 'del'
runSequence = require 'run-sequence'

{toSnakeCase, trim} = require 'strman'
{dest, archive} = G.basePath

gulp.task 'clean-archive', (cb) ->
  del(archive)

gulp.task 'archive', (cb) ->
  git.branch (branch) ->
    folderName = [
      moment().format('YYYY-MM-DD-HH-mm')
      if argv.o then 'o' else 'i'
      branch.replace(/[\-\/]/g, '_')
    ]

    folderName.push toSnakeCase(trim(argv.m)) if argv.m?
    folderName = folderName.join('-')

    gulp.src "#{dest}/**/*"
      .pipe gulp.dest("#{archive}/#{folderName}")
      .on 'end', ->
        runSequence('deploy') if argv.deploy
