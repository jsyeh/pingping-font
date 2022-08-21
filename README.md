# pingping-font
製作「萍萍體」手寫字體。嘗試製作字型前, 需要先製作一些輔助工具。

## 源由
我在2018年暑假幫我太太購買 [justwrite 手寫字服務](https://justwrite.tw), 先在稿紙上寫好全部的字, 再把手寫稿交給 justfont 的設計師製作字型。

2022年暑假完成手寫稿後, justfont 客服回覆「公司營運方向改變」, justwrite 服務已經停止。
所以我想親自幫我太太製作字型。

我沒有相關經驗, 需要邊想邊動手做。
首先想到的是字實在是太多了, 需製作對照表, 才能對照我太太的手寫稿, 進行造字的圖檔對應。
- 先針對對照表開發程式, 再逐一輸入電腦, 完成Unicode及手寫稿位置的對照表。
- 完成9200字對照表後, 需進行校對, 確認「對照表」及「掃描影像檔」無誤。

接下來將進入第二階段, 進行影像處理。先將影像檔轉正、切割, 之後找出每一筆劃(stroke)的輪廓(contour)。最後再利用曲線Fitting準備製作字型。

## 收穫
製作過程中, 我有一些收穫:
- 了解一些「簡體字」對應「繁體字」的規則
- 查詢許多字的唸法、意思、造字原則
- 有很多很棒的 Idea 一直跳出來
- 開發小工具時, 從規劃、逐步測試、寫程式, 看到程式慢慢成形, 很有成就感
- 程式設計的能力變得更好了
- 邊實作、邊規劃, 越來越接近目標, 很開心
- 從頭到尾把一件事情做好, 就是成功

## show_unicode
輸入4碼Unicode,便會秀出對應的中文字

![show_unicode.png](show_unicode.png)

## show_unicode_create_table
這個程式, 可連續輸入 4碼 Unicode, 再逐一秀出對應的中文字, 並建立table檔
- 輸入4碼會秀出中文字, 正確時按 SPACE or ENTER 便可確認送出
- 輸入欄位 now 可用 `mouseDragged()` 移動位置
- 輸入錯誤可按 BACKSPACE 清除字碼或更多
- 關於讀檔 `myLoadTable()`: 在setup()時如果存在table.txt便會讀入
- 關於寫檔 `mySaveTable()`: 每次輸入確定時, 便會寫檔
- 會儲在成 table.txt, 手動改檔名(換頁)即可

問題:
- P10最後1個字 \uf000 直式的全型～ 無法正確顯示 (微軟正黑體、SimSun都沒看到字)
- 處理部分香港字時有錯, 像 \u28468(𨑨) 和 \u23350(𣍐) 我的程式無法正確顯示&存檔
	- 經實驗, \u28468 會變成 \u2846 再加上8, 而不會合成一個字
	- 手動修改 table.txt 用 https://unicodeplus.com/U+28468 找字, 再複製到 Notepad
	- P43 28468(𨑨),23350(𣍐) 的 Unicode 是5碼, 我還無法處理
	- P99 香港用字補充 L7-L9 有17個字的 Unicode 也是5碼, 我還無法處理
	- P99 香港用字補充 L10 有3個字的 Unicode 也是5碼, 我還無法處理
	- P100 香港用字補充 L3-L5 有26個字的 Unicode 也是5碼, 我還無法處理
	- P100 香港用字補充 L7 有2個字的 Unicode 也是5碼, 我還無法處理
	- [stackoverflow](https://stackoverflow.com/questions/37679763/java-unicode-escape-with-more-than-4-hexadecimal-digits) 有人建議去查 [Java Character](https://docs.oracle.com/javase/8/docs/api/java/lang/Character.html) 文件
- TODO: 程式 `myLoadTable()` 利用 `splitToken(line[i], ",()")` 斷字, 但 P08 符號表剛好有這3個符號, 導致 `(()`、`())`、`(,)` 都被刪掉, 導致後面都呈現錯誤。需要例外處理。
	- 這個函式在 show_unicode_create_table 及 show_table_proofreading 都有用到

![show_unicode_build_table.png](show_unicode_build_table.png)

![show_unicode_build_table2.png](show_unicode_build_table2.png)

## show_table_proofreading
校稿工具程式
- 可把 table 目錄下的 table_xx.txt 的內容秀出來,
- 利用 `mouseWheel()` 來調整視窗的大小 `surface.setSize()`, 再計算字的相對位置並畫出
- 利用 `mouseDragged()` 調整(整篇文字的)Y捲動位置 shiftY
- 利用 `keyPressed()` 的 `LEFT` 和 `RIGHT` 來切換不同檔案, 逐一秀出來
- 檔案名會秀在程式的左上角, 方便了解正在秀哪一個檔案
- 手動使用上面操作, 讓寬度與(放背景)掃描稿一致, 方便逐一校對字稿

![show_table_proofreading.png](show_table_proofreading.png)

經過校正後, 掃描檔影像出錯、需重寫/掃描:
- P8 錯字: T % (英文也怪), 星號小心
- P10? 距離: ...
- P15 L7 錯字: 余
- P17 L5 髒字: 烈
- P21 L4 錯字: 薯
- P21 L9 錯字: 譯
- P25 L10 錯字: 全形底線(?)
- P27 L8 髒字: 
- P38 L5 錯字: 饌
- P47 L8-10 髒字: 
- P49 L5 錯字: 爧
- P56 L2 錯字: 886a(衪) 誤寫成 7942(祂)
- P56 L4 錯字: 99b1(馱) 誤寫成 馬犬
- P58 L5 錯字: 781d(砝) 誤寫成 78d5(磕)
- P79 L5 錯字: 6320(挠) 誤寫成 多1點
- P86 L1 缺字: 960a(阊) 漏寫左邊
- P87 L2 缺字: 8df9(跹) 漏寫右邊
- P88 L7 錯字: 88e3(裣) 誤寫成 示部
- P89 L1 缺字: 7228(爨)
- P89 L4 缺字: 9f6c(齬)
- P89 L7 缺字: 508c(傌) 漏寫右邊
- P89 L7 髒字: 4fe5(俥)
- P89 L9 髒字: 7e0a(縊)
- P92 L4 缺字: 86fa(蛺)
- P96 L6 缺字: 877a(蝺)
- P96 L7 錯字: 82d6(苖) 誤寫成 82d7(苗)
- P100 L5 錯字: 2561(塡) 誤寫成 586b(填)
- P100 L6 錯字: 784f(硏) 誤寫成 7814(研)
- P100 L6 錯字: 5a7e(婾) 誤寫成 5aae(媮)

## 對照表完成
- 己完成 P1-P60 含字頻5600+英數符號4頁, 對應6000字
- 已完成 P63,P64 日簡共用, 對應200字
- 已完成 P71-P88 簡化字補充
- 已完成 P89-P98 補到字頻6600
- 已完成 P99-P100 香港用字補充
- (缺/略過) P61,P62 日本50音(平假、片假)符號, P65-P70和製漢字

## TODO之後可做
(8/20寫的 50-60應該都有二度校稿過, 出錯的機會變小)
- TODO: 影像處理, 把 PDF 變成圖檔, 再依綠色方塊進行切割
- TODO: 可做 Web APP 在網頁進行Unicode/中文字對照, 也能進行字碼輸入/去查相關的文字典故
- TODO: 排版、試版: 調字高度的工具(同時秀一些句子), 調大小/調高度時, 會很有用
- TODO: 可請教justfont字形設計師: 有哪些字容易寫錯/眼歪? 這些經驗很有價值
- TODO: 可以去上課
- TODO: 字型常見的9個字: 永東國酬愛鬱靈鷹袋, 三、力