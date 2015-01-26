gulp = require 'gulp'
jade = require 'gulp-jade'
watch = require 'gulp-watch'
jadeAffected = require 'gulp-jade-find-affected'
data = require 'gulp-data'
path = require 'path'
less = require 'gulp-less'
plumber = require 'gulp-plumber'
lodash = require 'lodash'
coffee = require 'gulp-coffee'
uglify = require 'gulp-uglify'
minify = require "gulp-minify-css"

gulp.task 'jade', ->
  gulp.src './jade/*.jade'
    .pipe(plumber())
    .pipe data((file) ->
      mainJsonPath = './data/main.json'
      jsonPath = './data/' + path.basename(file.path, '.jade') + '.json'
      delete require.cache[require.resolve(jsonPath)]
      lodash.merge(require(jsonPath), require(mainJsonPath))
    )
    .pipe jade()
    .pipe(plumber.stop())
    .pipe gulp.dest './templates/'

gulp.task 'less', ->
  gulp.src './less/*.less'
    .pipe(plumber())
    .pipe less({
      paths: [ path.join(__dirname, 'less', 'includes') ]
    })
    .pipe minify()
    .pipe(plumber.stop())
    .pipe gulp.dest './less/'

gulp.task 'coffee', ->
  gulp.src './coffee/*.coffee'
    .pipe(plumber())
    .pipe coffee({ bare: true })
    .pipe uglify()
    .pipe(plumber.stop())
    .pipe gulp.dest './coffee/'

gulp.task 'jade-watch', ->

  watch './jade/**/*.jade', ->
    gulp.start 'jade'

gulp.task 'data-watch', ->
  watch './data/**/*.json', ->
    gulp.start 'jade'

gulp.task 'less-watch', ->
  watch './less/**/*.less', ->
    gulp.start 'less'

gulp.task 'coffee-watch', ->
  watch './coffee/**/*.coffee', ->
    gulp.start 'coffee'

gulp.task 'default', ['jade','less','coffee', 'jade-watch', 'less-watch', 'data-watch', 'coffee-watch']