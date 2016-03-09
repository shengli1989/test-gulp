# 安裝環境
1. 裝 [brew](http://brew.sh/index_zh-tw.html)
`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

- 裝 [nvm](https://github.com/creationix/nvm)
`brew install nvm`

- 裝 [node](https://nodejs.org/en/)
`nvm install node`

- clone repo 到你喜歡的資料夾下
`git clone https://github.com/unfoldgroup/starter2016.git`

- 要直接吃 sketch 檔生圖，要安裝 [sketchtool](http://www.sketchapp.com/tool/)
`Sketch.app/Contents/Resources/sketchtool/install.sh`
(Sketch.app 的路徑因個人環境而異)

- 安裝 [libvips](https://github.com/jcupitt/libvips)（縮圖用，安裝需要跑一段時間）
`brew install homebrew/science/vips --with-webp --with-graphicsmagick`

- 安裝專案需要的 package
`npm install`

- 安裝 gulp 在 global 環境中
`npm install gulp -g`

# 目前主要的 gulp tasks
- `gulp` or `gulp default`: 相當於 fireapp 的 watch
  - `gulp clean`: 把原本 build 資料夾的內容刪除
  - `gulp compile`: compile sass, jade 和 coffeescript
  - `gulp dev-server`: 開啟 browserSync 並且 watch 原始檔
- `gulp build`: 相當於 fireapp 的 build
  - `gulp minify`: 將 build 資料夾內的檔案壓縮
  - `gulp sitemap`: 根據 build 資料夾內的 html 產生 sitemap.xml

# gulp task 寫法
根據 task 的類型，在 gulp 資料夾下找個位置開啟一個新的 .js 或 .coffee 檔

先取得需要用到的常用變數

```coffee
{ src, dest } = G
```
以上 `G` 定義於 `global-vars.coffee`
然後開始定義 task

```coffee
gulp.task 'task-name', ->
  console.log('hello world')!
```

接著在 CLI 執行 `gulp task-name`，就可以看到成果了

# 檔案結構
```
.
├── config：設定檔
├── global-vars.coffee：gulp 用的全域變數
├── src: 工作檔
├── build: 最後生成的檔案目錄
├── gulp: gulp tasks
├── gulpfile.coffee: gulp 入口檔案
├── node_modules: 相依套件
├── package.json: 專案設定檔
└── readme.md: 說明檔
```


# 工作檔結構
```
src
├── jade
│   ├── data
│   ├── layouts
│   ├── mixin
│   ├── pages
│   └── partials
├── sass
│   ├── _layout.sass
│   ├── _mixin.sass
│   ├── _shared-config.scss
│   ├── _typography.sass
│   ├── _variable.sass
│   ├── all.sass
│   ├── base
│   ├── component
│   ├── page
│   └── partial
├── scripts
│   ├── global.coffee: 全站共用的 js
│   ├── page-name.coffee
│   └── util
└── sketch
    └── assets.sketch
```

# 待做事項
- asset 處理：搬移、縮放圖片，直接從 .sketch 匯出圖檔
- svg sprites
- deploy 相關：gh-pages 和 s3 的 deploy task
