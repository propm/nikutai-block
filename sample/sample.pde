float balx, baly, balvx, balvy;      //ボールの座標、速さ
float barx, bary, barw, barh;        //バーの座標、幅
int bwn, bhn, bw, bh;                //ブロックの個数、幅
int balr;                            //ボールの直径

class Block{
  int x, y;            //左上の座標
  boolean visible;     //表示・非表示
  
  Block(int i, int j){
    x = j*bw;
    y = i*bh;
    visible = true;
  }
  
  void drawer(){
    if(visible)  rect(x, y, bw, bh);
  }
  
  /*  ブロックとボールのあたり判定
   *  schange  今のループでまだボールの速さが反転されてないならtrue
   */
  boolean dicision(boolean schange){
    boolean hflag = false;
    boolean wflag = false;
    if(visible){
      if((x < balx - balr/2 && x + bw > balx - balr/2) ||
          (x < balx + balr/2 && x + bw > balx + balr/2))     wflag = true;
      if((y < baly - balr/2 && y + bh > baly - balr/2) || 
          (y < baly + balr/2 && y + bh > baly + balr/2))     hflag = true;
      if(wflag && hflag){
        visible = false;
        if(schange){
          balvx *= -1;
          balvy *= -1;
        }
        
        println();
        return false;
      }
    }
    
    return schange;
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
  balvx = 8;
  balvy = 8;
  balr = 20;
  bw = width/bwn;
  bh = (height/2)/bhn;
  
  blocks = new Block[bhn][bwn];
  
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      blocks[i][j] = new Block(i, j);
    }
  }
  
}

void draw(){
  barx = mouseX;
  balx += balvx;
  baly += balvy;
  
  dicision();
  boolean change = true;
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      change = blocks[i][j].dicision(change);
    }
  }
  
  background(255);
  
  fill(0, 250, 255);
  stroke(1);
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      blocks[i][j].drawer();
    }
  }
  
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
  
  //ボールが画面外に行かないように
  if(balx < balr/2){
    balx = balr/2;
    balvx *= -1;
  }
  if(balx > width - balr/2){
    balx = width - balr/2;
    balvx *= -1;
  }
  if(baly < balr/2){
    baly = balr/2;
    balvy *= -1;
  }
  
  //ボールとバーのあたり判定
  if(balx > barx - barw/2 && balx < barx + barw/2){
    if(baly + balr/2 > bary - barh/2 && baly - balr/2 < bary + barh/2){
      baly = bary - barh/2 - balr/2;
      balvy *= -1;
    }
  }
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  