# pingping-font
嘗試製作字型前,要先完成的一些工具

## show_unicode
輸入4碼Unicode,便會秀出對應的中文字

![show_unicode.png](show_unicode.png)

## show_unicode_create_table
這個程式, 可連續輸入 4碼 Unicode, 再逐一秀出對應的中文字, 並建立table檔
- 輸入4碼會秀出中文字, 正確時按 SPACE or ENTER 便可確認送出
- 輸入欄位 now 可用 mouseDragged() 移動位置
- 輸入錯誤可按 BACKSPACE 清除字碼或更多
- 關於讀檔 myLoadTable(): 在setup()時如果存在table.txt便會讀入
- 關於寫檔 mySaveTable(): 每次輸入確定時, 便會寫檔
- 已完成 table.txt 第1頁, 手動換頁即可
- 程式碼在處理部分香港字(如 Page 43 的 28468(𨑨),23350(𣍐), 會有問題。目前手動修改table.txt
- Java 無法將 \u28468 和 \u23350 正確顯示
(目前己完成 50頁 table 檔, 對應5000字)

![show_unicode_build_table.png](show_unicode_build_table.png)

![show_unicode_build_table2.png](show_unicode_build_table2.png)

