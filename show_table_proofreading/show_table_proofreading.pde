// 這個程式,目的是要比對(掃描圖檔 vs. table 中文對照表)
// 可讀入任一個 table 檔
// 再利用 keyPressed() 來決定看哪一頁、哪一個字
// 可利用 mouseWheel() 來調整視窗的大小, 並縮放內容的字
// 可任意調長寬, 做出和 show_unicode_build_table 一樣的畫面, 也拉成適合比對的程式
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
    //rect(x, y, h, h*1.5);
    fill(0);
    textAlign(CENTER, CENTER);
    textSize(h);
    text(word, x + h/2, y + h/2);
    textSize(h*0.4);
    text(codeString, x + h/2, y + h*1.4);
  }
}
ArrayList<Word> words=null;

int fileID=0;
ArrayList<String> filenames;
ArrayList<String> myFindAllTables(){
  ArrayList<String> list = new ArrayList<String>();
  for(int i=1; i<=89; i++){
    if(i==61 || i==62) continue; //日文假名符號
    if(i>=65 && i<=70) continue; //日文漢字
    list.add( "table/table_" + nf(i,2) + ".txt" );
  }
  return list;
}

void myLoadTable(String filename){
  String [] lines = loadStrings(filename);
  if(lines==null) return; //讀檔失敗時, 提早離開
  if(words==null) words = new ArrayList<Word>(); //第一次用時,要建構
  else words.removeAll(words); //每次要讀時, 要把 words 清空
  
  for(int i=0; i<lines.length; i++){
    String [] fields = splitTokens( lines[i], ",()" );
    for(int k=0; k<fields.length/2; k++){
      //小心,讀入的code是 hexdecimal code, 不能當 decimal code 傳給Word()
      Word one = new Word( fields[k*2+1].charAt(0), 0, 0 );
      words.add(one);
    }
  }  
}
void keyPressed(){
  if( keyCode==RIGHT ){
    fileID = ( fileID + 1 ) % filenames.size();
    myLoadTable( filenames.get(fileID) );
    myResize();
  }else if( keyCode==LEFT ){
    fileID = ( fileID - 1 + filenames.size() ) % filenames.size();
    myLoadTable( filenames.get(fileID) );
    myResize();
  }
  println(fileID);
}
void setup(){
  size(1730,200);
  surface.setResizable(true);
  surface.setLocation(50, 100);
  
  filenames = myFindAllTables();
  myLoadTable( filenames.get(fileID) ); //myLoadTable("table/table_01.txt");
  
  myResize();
  
  PFont font = createFont("微軟正黑體", 80);
  textFont(font);
}
void draw(){
  background(#FFFFF2);
  
  if( width!=width0 || height != height0 ) myResize();
  
  for( Word w : words ){
    w.draw(width/10/4.5);
  }
  fill(255);
  rect(0, 0, textWidth( "  " + filenames.get(fileID))+20, width/10/4/2);
  fill(0);
  textAlign(LEFT,TOP);
  text( "  " + filenames.get(fileID), 0, 0);
}
int width0 = 0, height0 = 0, shiftY = 0;
void myResize(){ //我自己的 callback 函式
  //寬度會決定每個字的大小、位置
  //高度會決定畫面最下面那行要放的位置
  width0 = width;
  height0 = height;
  int w1 = width / 10;
  int w2 = w1 / 4;
  for(int i=0; i<words.size(); i++){
    Word w = words.get(i);
    w.setPos( 50+(i%10)*w1, shiftY + int(i/10)*w2*2 );
  }
}
void mouseDragged(){
  shiftY += mouseY-pmouseY;
  myResize();
}
void mouseWheel(MouseEvent event){
  float e = event.getCount();
  float scale = (100 - e) / 100.0;
  print(100 - e, " ");
  surface.setSize( int(width*scale), int(height*scale) );
}
