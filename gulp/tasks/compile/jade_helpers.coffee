{ readConfig, readData, spritesUrl } = G

sample = require 'lodash/sample'
sampleSize = require 'lodash/sampleSize'
assign = require 'lodash/assign'
jade = require 'pug'

sharedConfig = readConfig('shared')

sentenceStart = ["公司倚老賣老的設計同事，","就是因為你幫行銷改圖改到人家爽為止，","一開始說只要設計名片，","談好價錢以後才說LOGO也要順便做，","幫朋友設計不收錢都被當天經地義，","設計不是販賣機，","這些字體設計幫我省了90次修改，","老板，如果被業主否定設計，","不要因為業主刻薄的要求，","每一天擺著臭臉來上班，","都被你的負能量影響工作情緒，","繼續這樣下去的話，","嘴炮也是設計的一環，","老闆會逾越本分去管你的設計方式其實蠻稀鬆平常的，","但遇到連客戶都會去管你的作法就真的.......","什麼那邊移左邊一點，","那邊移右邊一點，","不管我做什麼你們都說好好看，","你花時間蒐集資料、構圖、上電腦完稿、細部討論調整，","都需要時間，","我他媽的的算友情價，還嫌貴，","又拿截圖圖稿去偷印，","就像是湊齊七顆龍珠才可以許願，","前面校稿沒意見，","定搞再來乾坤大挪移，","靠北我不是設計師，","但我們老闆都叫我幫她設計公司文宣，","嘴巴說我欣賞你們年輕人創意，","結果最後我只是一個操作電腦的轉譯機器人，","業務：要是我會用你那個什麼軟體，","媽的拍爛了的照片，","設計是最沒尊嚴的行業，","當業務被客戶罵至少還有獎金領，","當設計被罵是應該，","星期五下午才說要做傳單，","問妳請問妳要什麼樣的風格和感覺，","妳說隨便、可愛、簡潔，","我覺得跟客戶要照片是一件非常困難的事情，","您好請給我一張您的個人照片，","我要輸出大背景放在展場上，","千萬千萬不要使用手機拍攝的照片，","請在燈光足夠的地方下拍攝，","您好，不行喔，請勿用手機拍攝，","我們要的照片畫素要夠大，","您好，不能用，","請用您的類單相機","你幫我看一下，","客人傳來很多張原始照片...","我一看每張都被他們公司LOGO字的浮水印，","還加上白底就佔去三分之一...","你們薪水都比我高，","政府修個法我們趕圖掛號，","你業主三不五時就改個圖，","公所承辦不爽就給你拖件，","不然就審圖壓件不給你過，","一個案子改來改去就算了，","還從原本設計改到現在這，","所以幫親戚各種設計，","死都不加，","靠我以前都覺得加浮水印或出處很醜很假掰，","被抄襲了伸張自己的權利還被說這樣的話，","啊，Photoshop當了，","呵呵呵，","呵呵呵呵呵呵呵呵呵呵呵呵呵，","呵呵呵呵呵呵哈哈哈哈哈嘻嘻嘻嘻嘻嘻嘻嘻嘻，","不要每次我弄完才再說，","不是這個，我要的尺寸是巴拉巴拉巴拉....","我不要這樣的感覺，我要巴拉巴拉巴拉....","有的時候設計師自己跟人家講的東西就只能通靈，","最氣人的是後面很無辜的跟你說，","放的就那幾隻最芭樂的，","有特色一點的設計師作品都沒有，","視野好狹窄的感覺，","建議你還是貼春聯就好了，","品味離你實在太遠，","遠到你完全沒有概念只好一直學人像個四不像，","幹之前都只覺得責任制很靠北，","難道我們設計師、工程師也要因為你常每天變想法，","況且，我給你的報價是多便宜，","你很清楚，","說案子很趕的人是你，","我不知道你們是誰，","但反正你是老闆嘛，","你們可以罵的那麼難聽，","說與其在這邊囂張，","不如自己去當老闆，","設計師一開始就是有人需要才會有的職業，","與其在這裡打嘴砲，","說好的下班時間是6點，","每天都加班加班加班還有做不完假日要去幫忙...","不要跟我說責任制","雖然是老哽，但還是覺得很靠北，","本來要我拿以前舊稿修改，","交出去後又退回要求從側面改正面，","哇咧靠北，這不是3D，","幾乎重畫等級相當，","阿提出這種要求的你，"]
sentenceEnd = ["我一定做比你快多了。","說改就改。","請你把你的想法和業主分享。","員工們都好難受。","星期一早上就問，幾點可以交？","妳怎麼不先去食屎呢？","這張可以嗎？","能修到完美那幹麻要請攝影師？","我：不好意思，可以請重新給我沒有浮水印的嗎？","不然你幫我PS掉好了，稿件很快會做好吧？","照片要多大？","那這張呢？","隨便拉一拉轉一轉不就行了？","你要蓋工寮就說蓋工寮好嗎？","為什麼要跟我說你要蓋民宿？","畫圖很累很傷眼睛你知道不？","可以把腦袋剁掉嗎？","什麼時候被抄襲變的理所當然了？","所以只能摸摸鼻子自認倒楣？","請你發揮你設計的專長來想想這個怎麼做比較好。","我要高貴黑，但是我要她看起來很亮。","我要像APPLE官網的那種效果。","畫圖而已，我也會啊。","我要這個頁面用甚麼甚麼特效？","我要甚麼甚麼效果？","阿這不是很簡單？","蛤~你做不出來哦？","我們就應該無條件幫你修改嗎？","你是多有用？","你的美感有多好？","你曾經嘗試設計任何圖樣嗎？","反正設計師沒個美感都比你們要差啊，不是嗎？","那麼想必也是有自己創業的吧？","不然為什麼不是你自己包辦？","設計出來之後有人要嗎？還是最後出現在紙類回收桶了？","不是很厲害？","憑自己會幾個軟體就很囂張？","對啦，就是贏在你們不會，設計師會啊？","你的腦子裝屎嗎？","照鏡子時側面和正面是一模一樣膩？","那可以先給我尺寸和方向嗎?","可以靠北公司電腦只要開indesign再加上Ai就會當機嗎？","有人跟我一樣嗎？","還在用10年的老爺爺MAC？","你當我只有你一個客戶？","從今天開始我每張圖都要加。","不會，我只會用佛陀夏普還有以喇死吹特。","靠北我好怕這樣的未來。","做的好委屈｡","理所當然當作免費慈善事業是嗎？"]
sentenceHowl = ["一分錢一分貨麻，那就隨便做囉！","請不要用手機拍攝喔！","客：可是我只有這些！","就叫你不要用手機拍你聽不懂嗎！！！！！","人家才會叫你美工！！！！","沒獎金，算了！","薪水低，算了！","加班沒時間睡覺，算了！","眼睛爛掉肝爆掉健康，算了！","不小心印錯字、賠錢、薪水拿去，算了！","乾脆這輩子都送你，算了！","不是你投幣就馬上掉出來！","隨便拍，拍爛的找個好的後製師就好！","說很簡單那你做！","那臉上灰白了那一塊給我修好阿幹！","別再和我說曝光的照片能修到沒曝？","移你媽！母親節快樂！","新細明體什麼配色都好醜阿！","你腦子有洞啊！","甚麼鬼的都被朋友陰，你媽啦！","靠北海報的資訊一次給齊啦！","不一次給七顆我是要怎樣幫你完成願望啦幹！","媽的都給妳講就飽了！","不要以為寫上設計兩個字就當你是設計師了！","修改要花很多時間耶！","幹！有尺寸就要設計廣告！","簡單說還是那個字，土！","說確認的人是你耶！","看完才知道責任制根本違法！","把我的肝跟青春還給我拉幹！","不如去學學軟體怎麼用、然後抱個設計獎回來吧！","公司人少也不是這樣用的阿是不是！","我每天到家都要9點了啊！","還幾乎都是每天最早到公司這不能忍啊！","我是實習生啊！不支薪啊！","媽蛋我該做完的都做完了為甚麼我還要跟你浪費生命阿！","我！想！回！家！啊！","要我加班給薪水啊！","有錢好辦事啦！","什麼都沒有要我加班加個屁啦！","更何況我又不是東西沒做完我做完了啊！","到底在加什麼班加心酸的逆！","淦！設計師真不是人當的！"]

metaData = readData('meta')

getHelpers = (pageLevelString) ->
  assign(metaData, sharedConfig,
    sprites_url: (name) ->
      rel = if argv.relative then pageLevelString else '/'
      "#{rel}#{spritesUrl}##{name}"
    env: argv.env
    isArchive: !!argv.archive
    sample: sample
    sampleSize: sampleSize
    getData: readData
    moment: require 'moment'
    mq:
      tablet: "(min-width: #{sharedConfig?.breakpoints?.tablet})"
      desktop: "(min-width: #{sharedConfig?.breakpoints?.desktop})"

    zh_lorem_sentence: ->
      sample(sentenceHowl)

    zh_lorem_sentences: (int) ->
      sampleSize(sentenceStart, int).concat([sample(sentenceEnd)]).join('')

    zh_lorem_paragraphs: (int) ->
      sampleSize(sentenceStart, int * 4).concat([sample(sentenceEnd)]).join('')

    image_url: (name) ->
      G.getImageUrl(name, pageLevelString)

    style_tag: (name) ->
      path = G.getCssPath(name, pageLevelString)
      jade.render "link(rel='stylesheet' href='#{path}')"

    script_tag: (name) ->
      path = G.getJsPath(name, pageLevelString)
      jade.render "script(src='#{path}')"
  )

module.exports = getHelpers
