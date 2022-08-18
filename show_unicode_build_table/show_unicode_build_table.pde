// 這個程式, 可連續輸入 4碼 Unicode, 再逐一秀出對應的中文字
// 輸入4碼會秀出中文字, 正確時按 SPACE or ENTER 便可確認送出
// 輸入欄位 now 可用 mouseDragged() 移動位置
// 輸入錯誤可按 BACKSPACE 清除字碼或更多
// 關於讀檔 myLoadTable(): 在setup()時如果存在table.txt便會讀入
// 關於寫檔 mySaveTable(): 每次輸入確定時, 便會寫檔
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
    codeString = "" + hex(code, 4).toLowerCase();
    word = c;
    setPos(_x, _y);
  }
  Word(int _dec_code, int _x, int _y){
    code = _dec_code; //小心, 不能傳入 hex 字串
    codeString = "" + hex(code, 4).toLowerCase();
    word = (char)code;
    setPos(_x, _y);
  }
  void draw(float h){
    fill(255, 200);
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
  size(600,800);
  words = new ArrayList<Word>();
  now = new Word(width/2, height/2);
  now.setPos(width/2-50, height-180);
  
  myLoadTable(); //如果存在 table.txt 便將全部的資料讀入

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
int cursorX0=50, cursorY0=20;
int cursorX=cursorX0, cursorY=cursorY0;
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
    mySaveTable(); //將整個檔案存檔(很頻繁)
  }else if(keyCode==BACKSPACE && now.codeString.length()>0) { //打錯字可用倒退鍵
    now.codeString = now.codeString.substring(0, now.codeString.length()-1);
    now.code = now.code / 16;
  }else if(keyCode==BACKSPACE && now.codeString.length()==0 && words.size()>0){
    //要刪更多字, 但 now 已清空, 且 words 還有多的字, 便可以把 words 最後一個字取下來
    Word temp = words.get(words.size()-1);
    temp.setPos(now.x, now.y);
    now = temp;
    words.remove(words.size()-1);
    cursorX -= 50;
    if(cursorX<=0){
      cursorX = 500;
      cursorY -= 50*1.5;
    }
    print(cursorX, cursorY, "--");
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
void mySaveTable(){
  //將整個檔案存檔
  String [] lines = new String[words.size()/10+1];
  for( int i=0; i<words.size(); i++){
    if(i%10==0) lines[i/10]=new String();
    Word w = words.get(i);
    lines[i/10] += w.codeString + "(" + w.word + "),";
  }
  saveStrings("table.txt", lines);  
}
void myLoadTable(){
  String [] lines = loadStrings("table.txt");
  if(lines==null) return; //讀檔失敗時, 提早離開
  
  words.removeAll(words);
  cursorX=cursorX0;
  cursorY=cursorY0;
  for(int i=0; i<lines.length; i++){
    String [] fields = splitTokens( lines[i], ",()" );
    for(int k=0; k<fields.length/2; k++){
      //小心,讀入的code是 hexdecimal code, 不能當 decimal code 傳給Word()
      Word one = new Word( fields[k*2+1].charAt(0), cursorX, cursorY );
      words.add(one);
      cursorX += 50;
    }
    if(i<lines.length-1){
      cursorY += 50*1.5;
      cursorX = cursorX0;
    }
  }
}
