# pingping-font
嘗試製作字型前,要先完成的一些工具

## show_unicode
輸入4碼Unicode,便會秀出對應的中文字

![show_unicode.png](show_unicode.png)

## show_many_unicode
這個程式, 可連續輸入 4碼 Unicode, 再逐一秀出對應的中文字
- 輸入4碼會秀出中文字, 正確時按 SPACE or ENTER 便可確認送出
- 輸入欄位 now 可用 mouseDragged() 移動位置
- 輸入錯誤可按 BACKSPACE 清除字碼或更多
- 關於讀檔 myLoadTable(): 在setup()時如果存在table.txt便會讀入
- 關於寫檔 mySaveTable(): 每次輸入確定時, 便會寫檔

![show_many_unicode_and_build_table.png](show_many_unicode_and_build_table.png)
