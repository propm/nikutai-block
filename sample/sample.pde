float balx, baly, balvx, balvy;      //ボール
float barx, bary, barw, barh;        //バー
int bwn, bhn;                        //ブロックの個数
int balr;

class Block{
  int x, y;
  
  Block(int i, int j){
    x = j*width/bwn;
    y = i*(height/2)/bhn;
    println("x: "+x+" y: "+y);
  }
  
  void drawer(){
    rect(x, y, width/bwn, (height/2)/bhn);
  }
}

Block[][] blocks;

void setup(){
  size(800, 800);
  bwn = 8;
  bhn = 8;
  barw = width/5;
  barh = height/50;
  bary = height/50*44;
  balx = width/2;
  baly = height/7*5;
  balvx = 4;
  balvy = 4;
  balr = 20;
  
  blocks = new Block[bhn][bwn];
  
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      blocks[i][j] = new Block(i, j);
    }
  }
  
}

void draw(){
  background(255);
  
  fill(0, 250, 255);
  stroke(1);
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      blocks[i][j].drawer();
    }
  }
  
  barx = mouseX;
  balx += balvx;
  baly += balvy;
  
  dicision();
  
  noStroke();
  fill(0, 255, 0);
  ellipse(balx, baly, balr, balr);
  fill(255, 0, 134);
  rect(barx - barw/2, bary - barh/2, barw, barh);
}

void dicision(){
  //バーが画面外に行かないように
  if(barx < barw/2)           barx = barw/2;
  if(barx > width - barw/2)   barx = width - barw/2;
  
  //ボールとバーのあたり判定
  if(balx > barx - barw/2 && balx < barx + barw/2){
    if(baly > bary - barh/2){
      baly = bary - barh/2;
      balvy = -balvy;
    }
  }
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  