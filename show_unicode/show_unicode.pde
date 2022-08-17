//這個程式的主要功能: 輸入4碼 Unicode 轉換秀出對應的中文字
PFont [] fonts = new PFont[3];
void setup(){
  size(500,500);
  //https://blog.justfont.com/2018/11/macfonts-jiyukobo-mincho/
  //Mac 內建字體的故事：柊野明朝 Hiragino Mincho 與游明朝 Yu Mincho 
  fonts[0] = createFont("微軟正黑體", 80); //zh_tw 繁體中文字型
  fonts[1] = createFont("新細明體", 80); //jp 日文字型明朝體 暫用新細明體
  fonts[2] = createFont("SimSun", 80); //zh_cn 簡體中文字型 茶(\u8336)
  textFont(fonts[0]);
  textAlign(LEFT,CENTER);
}
void draw(){
  background(#FFFFF2);
  fill(0);
//Unicode 相關技術資料
//https://www.delftstack.com/zh-tw/howto/java/unicode-characters-in-java/
//  s = Character.toString((char)24171);
//https://ithelp.ithome.com.tw/articles/10082051
//  System.out.println((int)'幫');
//  System.out.println(Integer.toHexString(24171));
//  System.out.println(Integer.toHexString('幫'));
//  System.out.println("iT \u90A6 \u5e6b \u5fd9");
//https://www.cns11643.gov.tw/wordView.jsp?ID=87933&SN=&lang=tw
//  全字庫-中文標準交換碼 CNS 11643
  textFont(fonts[0]);
  text("請" + "\u8f38\u5165", 50, 50);// u後面大小寫都可對應到中文字
  text("code:" + codeString + ((frameCount/30%2==0)?"|":""), 50, 150);
  textFont(fonts[0]);
  textSize(150);
  text(word, 50, 300);
  textFont(fonts[1]);
  text(word, 200, 300);
  textFont(fonts[2]);
  text(word, 300, 300);
}
int code = 0x8336;
String codeString = "8336";
String word = "茶";
void keyPressed(){
  if(keyCode==BACKSPACE && codeString.length()>0) { //打錯字可用倒退鍵
    codeString = codeString.substring(0, codeString.length()-1);
    code = code / 16;
  }else if(key>='0' && key<='9'){ 
    codeString += key;
    code = code * 16 + ( key - '0' );
  }else if(key>='a' && key<='f'){
    codeString += key;
    code = code * 16 + ( key - 'a' + 10 );
  }else if(key>='A' && key<='F'){
    codeString += (key-'A'+'a');
    code = code * 16 + ( key - 'a' + 10 );
  }
  if(codeString.length()==4) word = Character.toString((char)code);
  //集滿4碼,便將 word準備好, 再利用 text(word, 50, 300) 秀出來
}
