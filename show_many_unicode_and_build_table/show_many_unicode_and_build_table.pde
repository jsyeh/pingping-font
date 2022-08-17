// 這個程式, 可連續輸入 4碼 Unicode, 再逐一秀出對應的中文字
// 輸入4碼會秀出中文字, 正確時按 SPACE or ENTER 便可確認送出
// 輸入欄位 now 可用mouseDragged()移動位置
// 輸入錯誤可按 BACKSPACE 清除字碼或更多
// 還沒有將輸入的檔案存檔
class Word {
  int code = 0;
  String codeString = "";
  char word = ' ';
  int x, y;
  void setPos(int _x, int _y){
    x = _x;  y = _y;
  }
  Word(int _x, int _y){
    setPos(_x, _y);
  }
  Word(char c, int _x, int _y){
    code = (int)c;
    codeString = "" + hex(code, 4);
    word = c;
    setPos(_x, _y);
  }
  Word(int _code, int _x, int _y){
    code = _code;
    codeString = "" + hex(code, 4);
    word = (char)code;
    setPos(_x, _y);
  }
  void draw(float h){
    noFill();
    rect(x, y, h, h*1.5);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(h);
    text(word, x + h/2, y + h/2);
    textSize(h*0.4);
    text(codeString, x + h/2, y + h*1.25);
  }
}
ArrayList<Word> words;
Word now;
void setup(){
  size(600,600);
  words = new ArrayList<Word>();
  now = new Word(width/2, height/2);
  now.setPos(width/2, height/2);

  PFont font = createFont("微軟正黑體", 30);
  textFont(font);
}
void draw(){
  background(#FFFFF2);
  for( Word w : words ){
    w.draw(48);;
  }
  now.draw(100);
}
//int code = 0x8336;
//String codeString = "8336";
//String word = "茶";
int cursorX=50, cursorY=20;
void keyPressed(){
  if((key==' ' || keyCode==ENTER) && now.codeString.length()==4){
    //當now的codeString湊齊4碼, 按下SPACE或ENTER,便送出, 進入words
    Word temp = new Word(now.x, now.y);
    words.add(now);
    now.setPos(cursorX, cursorY);
    now = temp;
    cursorX+=50;
    if(cursorX>=550){
      cursorX = 50;
      cursorY += 50*1.5;
    }
  }else if(keyCode==BACKSPACE && now.codeString.length()>0) { //打錯字可用倒退鍵
    now.codeString = now.codeString.substring(0, now.codeString.length()-1);
    now.code = now.code / 16;
  }else if(keyCode==BACKSPACE && now.codeString.length()==0 && words.size()>0){
    //要刪更多字, 但 now已清空, 且 words 還有多的字, 便可以把 words 最後一個字取下來
    Word temp = words.get(words.size()-1);
    temp.setPos(now.x, now.y);
    now = temp;
    words.remove(words.size()-1);
    cursorX -= 50;
    if(cursorX<=0){
      cursorX = 500;
      cursorY -= 50*1.5;
    }
  }else if(key>='0' && key<='9'){ 
    now.codeString += key;
    now.code = now.code * 16 + ( key - '0' );
  }else if(key>='a' && key<='f'){
    now.codeString += key;
    now.code = now.code * 16 + ( key - 'a' + 10 );
  }else if(key>='A' && key<='F'){
    now.codeString += (key-'A'+'a');
    now.code = now.code * 16 + ( key - 'a' + 10 );
  }
  if(now.codeString.length()==4) now.word = (char)now.code;
  //集滿4碼,便將 word準備好, 再利用 text(word, 50, 300) 秀出來
}
void mouseDragged(){
  now.x += (mouseX-pmouseX);
  now.y += (mouseY-pmouseY);
}
