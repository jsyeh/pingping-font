# pingping-font
製作「萍萍體」手寫字體。嘗試製作字型前, 需先製作輔助工具。

## 源由
2018年暑假幫太太購買 justwrite [手寫字服務](https://justwrite.tw), 要先在稿紙上寫好9200字, 再把手稿交給 justfont 設計師製作字型。

2022年暑假完成手稿後, justfont 客服回覆「公司營運方向改變」, justwrite 服務已經停止。
所以我想親自幫我太太製作字型。

我沒有相關經驗, 需要邊想邊動手做。
首先想到的字太多, 需製作對照表, 以對照手稿, 進行造字圖檔對應。
- 先開發「對照表」程式, 再逐一輸入電腦, 完成 Unicode 手寫稿位置的對照表。
- 完成 9200 字「對照表」後, 需進行校對, 確認「對照表」及「掃描影像檔」無誤。

接下來進入第二階段, 進行影像處理。先將影像檔轉正、切割, 之後找出每一筆劃(stroke)的輪廓(contour)。最後再利用曲線 Fitting 準備製作字型。

## 收穫
製作過程中, 我有一些收穫:
- 了解一些「簡體字」對應「繁體字」的規則
- 查詢許多字的唸法、意思、造字原則
- 有很多很棒的 Idea 一直跳出來
- 開發小工具時, 從規劃、逐步測試、寫程式, 看到程式慢慢成形, 很有成就感
- 程式設計的能力變得更好
- 邊實作、邊規劃, 越來越接近目標, 很開心
- 從頭到尾把一件事情做好, 就是成功

## show_unicode
輸入4碼 Unicode 後, 秀出對應的中文字

![show_unicode.png](show_unicode.png)

## show_unicode_create_table
可連續輸入 4碼 Unicode, 再逐一秀出對應的中文字, 並建立 table 檔
- 輸入4碼會秀出中文字, 按 SPACE or ENTER 「確定送出」
- 輸入欄位 now 可用 `mouseDragged()` 移動位置
- 輸入錯誤可按 BACKSPACE 清除字碼or更多
- 關於讀檔 `myLoadTable()`: 在 `setup()` 若存在 `table.txt` 會讀入
- 關於寫檔 `mySaveTable()`: 每字輸入「確定送出」, 便會寫檔 `table.txt`
- 完成每頁 100 字, 再手動將 `table.txt` 改檔名(換頁)即可

對照表完成
- 己完成 P1-P60 字頻5600 + 英數符號4頁, 對應6000字
- 已完成 P63,P64 日簡共用, 對應200字
- 已完成 P71-P88 簡化字補充
- 已完成 P89-P98 字頻6600
- 已完成 P99-P100 香港用字補充
- (缺/略過) P61,P62 日本50音(平假、片假)符號, P65-P70和製漢字

問題:
- P10最後1個字 \uf000 直式的全型～ 無法正確顯示 (微軟正黑體、SimSun都沒看到字)
- 處理部分香港字時有錯, 像 \u28468(𨑨) 和 \u23350(𣍐) 我的程式無法正確顯示&存檔
	- 經實驗, \u28468 會變成 \u2846 再加上8, 而不會合成一個字
	- 手動修改 table.txt 用 https://unicodeplus.com/U+28468 找字, 再複製到 Notepad
	- P43 28468(𨑨), 23350(𣍐) 的 Unicode 是5碼, 我還無法處理
	- P99 香港用字補充 L7-L9 有17個字的 Unicode 也是5碼, 我還無法處理
	- P99 香港用字補充 L10 有3個字的 Unicode 也是5碼, 我還無法處理
	- P100 香港用字補充 L3-L5 有26個字的 Unicode 也是5碼, 我還無法處理
	- P100 香港用字補充 L7 有2個字的 Unicode 也是5碼, 我還無法處理
	- [stackoverflow](https://stackoverflow.com/questions/37679763/java-unicode-escape-with-more-than-4-hexadecimal-digits) 有人建議去查 [Java Character](https://docs.oracle.com/javase/8/docs/api/java/lang/Character.html) 但好像現有字型不支援
- TODO: 程式 `myLoadTable()` 利用 `splitToken(line[i], ",()")` 斷字, 但 P08 符號表剛好有這3個符號, 導致 `(()`、`())`、`(,)` 都被刪掉, 導致後面都呈現錯誤。需要例外處理。
	- `myLoadTable() 函式在 show_unicode_create_table 及 show_table_proofreading 都有用到

![show_unicode_build_table.png](show_unicode_build_table.png)

![show_unicode_build_table2.png](show_unicode_build_table2.png)

## show_table_proofreading
校稿工具程式
- 可把 table 目錄下 `table_xx.txt` 的內容秀出來,
- 利用 `mouseWheel()` 來調整視窗的大小 `surface.setSize()`, 重新計算字的相對位置
- 利用 `mouseDragged()` 調整(整篇文字的)Y捲動位置 shiftY
- 利用 `keyPressed()` 的 `LEFT` 和 `RIGHT` 來切換不同檔案, 逐一秀出來
- 檔案名會秀在程式的左上角, 方便了解正在秀哪一個檔案
- 使用上面操作, 手動讓寬度與(放背景)掃描稿一致, 方便逐一校對字稿

![show_table_proofreading.png](show_table_proofreading.png)

校正發現(掃描檔影像)出錯、已重寫/重新掃描:
- P8 錯字: T % (英文也怪), 星號小心 (已更正)
- P9 距離: ... (暫不修正)
- P15 L7 錯字: 余 (其實是書法字,把直行突出未)
- P17 L5 髒字: 烈 (已用立可白擦乾淨)
- P21 L4 錯字: 薯 (已更正)
- P21 L9 錯字: 譯 (其實是書法字,下方羊多一劃)
- P25 L10 錯字: 全形底線 (已更正)
- P27 L9 髒字: 鄭 (已用立可白擦乾淨) 
- P38 L5 錯字: 饌 (已更正)
- P47 L8-10 髒字: (已用立可白擦乾淨)
- P49 L5 髒字: 爧 (已用立可白擦乾淨)
- P56 L2 錯字: 886a(衪) 誤寫成 7942(祂) (已更正)
- P56 L4 錯字: 99b1(馱) 誤寫成 馬犬 (已更正)
- P58 L5 錯字: 781d(砝) 誤寫成 78d5(磕) (已更正)
- P79 L5 錯字: 6320(挠) 誤寫成 多1點 (已更正)
- P86 L1 缺字: 960a(阊) 漏寫左邊 (已更正)
- P87 L2 缺字: 8df9(跹) 漏寫右邊 (已更正)
- P88 L7 錯字: 88e3(裣) 誤寫成 示部 (已更正)
- P89 L1 缺字: 7228(爨) (已更正)
- P89 L4 缺字: 9f6c(齬) (已更正)
- P89 L7 缺字: 508c(傌) 漏寫右邊 (已更正)
- P89 L7 髒字: 4fe5(俥) (已用立可白擦乾淨)
- P89 L9 髒字: 7e0a(縊) (已用立可白擦乾淨)
- P92 L4 缺字: 86fa(蛺) (已更正)
- P96 L6 缺字: 877a(蝺) (已更正)
- P96 L7 錯字: 82d6(苖) 誤寫成 82d7(苗) (已更正)
- P100 L5 錯字: 2561(塡) 誤寫成 586b(填) (已更正)
- P100 L6 錯字: 784f(硏) 誤寫成 7814(研) (已更正)
- P100 L6 錯字: 5a7e(婾) 誤寫成 5aae(媮) (已更正)

## TODO之後可做
- TODO: 影像處理, 把 PDF 變成圖檔、依綠色方塊轉正、進行方塊切割
- TODO: Web APP Unicode/中文字對照 (小心字型問題)
- TODO: Web APP 可依據字頻, 查閱全部的字 
- TODO: 能字碼輸入/去查相關的文字典故
- TODO: 排版、試版: 調字高度的工具(同時秀一些句子), 調大小/調高度時, 會很有用
- TODO: 可請教justfont字形設計師: 有哪些字容易寫錯/眼歪? 這些經驗很有價值
- TODO: 可以去上課
- TODO: 字型設計基礎9字: 永東國酬愛鬱靈鷹袋 + 今三力, 變出 300字部首、7200常用字、完整13053字 (3+8 to 300 to 7,200 to 13,053)
- TODO: 2022-08-22 AI產生字型 5字生出1萬4000字 [筑波大學AI Venture字體生成系統專利申請](https://www.itmedia.co.jp/news/articles/2208/17/news178.html)
