# 安裝 package
1. 裝 [brew](http://brew.sh/index_zh-tw.html)
`ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"`

2. 裝 [nvm](https://github.com/creationix/nvm)
`brew install nvm`

3. 裝 [node](https://nodejs.org/en/)
`nvm install node`

4. 安裝專案需要的 package
`npm install`

# 檔案結構
```
.
├── src: 工作檔
├── build: 最後生成的檔案目錄
├── gulp: gulp tasks
├── gulpfile.coffee: gulp 入口檔案
├── node_modules: 相依套件
├── package.json: 專案設定檔
└── readme.md: 說明檔
```

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

```js
gulp = require('config-gulp').gulp
src = require('config-gulp').src
dest = require('config-gulp').dest
```

然後開始定義 task

```js
gulp.task('task-name', function(){
  console.log('hello world')!
})
```

接著在 CLI 執行 `gulp task-name`，就可以看到成果了

# 工作檔結構
```
src
├── data.yml
├── jade
│   ├── layouts
│   └── pages
├── robot.txt
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
│   ├── main.coffee
│   ├── page-name.coffee
│   └── util
└── shared-config.yml: jade, sass, coffee 共用變數，比如 breakpoints
```

# 待做事項
- asset 處理：搬移、縮放圖片，直接從 .sketch 匯出圖檔
- iconfont：從 .sketch 檔轉成 iconfont
- deploy 相關：gh-pages 和 s3 的 deploy task
