# to apply any file in any folder, use **/* - https://github.com/mahnunchik/gulp-responsive/issues/28

module.exports = [
  {
    'oval/*.png': [
      {
        width: 150
        rename:
          suffix: '@1x'
      }
      {
        width: 150 * 2
        rename:
          suffix: '@2x'
      }
    ]
    'hero.png': [
      {
        width: 700
        rename:
          suffix: '-700'
      }
      {
        width: 700 * 2
        rename:
          suffix: '-700@2x'
      }
    ]
  }
  {
    errorOnUnusedImage: false
    passThroughUnused: true
  }
]