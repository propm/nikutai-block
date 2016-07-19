float balx, baly;                            //ボールの座標
float barx, barbx, bary, barw, barh, barvx;  //バーの座標、ひとつ前のフレームの座標、幅、速度
int bwn, bhn, bw, bh;                        //ブロックの個数、幅
int balr;                                    //ボールの直径
boolean start;                               //trueならゲームスタート

class Block{
  int x, y;            //左上の座標
  boolean visible;     //表示・非表示
  
  //初期化
  Block(int i, int j){
    x = j*bw;
    y = i*bh;
    visible = true;
  }
  
  //描画
  void drawer(){
    if(visible)  rect(x, y, bw, bh);
  }
  
  //ブロックとボールのあたり判定
  boolean dicision(boolean schange){
    
    //ボールが上から来ていたならupflag = true
    boolean upflag = false;
    boolean downflag = false;
    boolean leftflag = false;
    boolean rightflag = false;
    
    if(visible){
      if(x < balx - balr/2 && x + bw > balx - balr/2){
        leftflag = true;
      }
      if(x < balx + balr/2 && x + bw > balx + balr/2){
        rightflag = true;
      }
      if(y < baly - balr/2 && y + bh > baly - balr/2){
        downflag = true;
      }
      if(y < baly + balr/2 && y + bh > baly + balr/2){
        upflag = true;
      }
      if((upflag || downflag) && (leftflag || rightflag)){
        visible = false;
        if(upflag && downflag)     balv.x *= -1;
        if(leftflag && rightflag)  balv.y *= -1;
        
        println("a");
        
        return false;
      }
    }
    
    return true;
  }
}

Block[][] blocks;      //ブロックの配列
PVector balv;          //ボールの速度ベクトル

void setup(){
  size(800, 800);
  init();
}


//初期化用関数
void init(){
  
  //各種初期値設定
  bwn = 8;
  bhn = 8;
  barw = width/5;
  barh = height/50;
  barx = width/2;
  bary = height/50*44;
  balx = width/2;
  baly = height/7*5;
  balv = new PVector(1, 3);
  balv.setMag(14);
  balr = 20;
  bw = width/bwn;
  bh = (height/2)/bhn;
  start = false;
  
  //ブロック生成
  blocks = new Block[bhn][bwn];
  
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      blocks[i][j] = new Block(i, j);
    }
  }
  
  //最初の描画
  drawing();
  textSize(40);
  text("Press \"space\" to play!", width/50*13, height/9*5);
}

void draw(){
  if(start){
    process();    //処理
    drawing();    //描画
  }
}

//処理用関数
void process(){
  
  //座標移動
  barx = mouseX;
  balx += balv.x;
  baly += balv.y;
  
  barvx = barx - barbx;  //バーの速さを代入

  //各種あたり判定
  //ボールとバー
  dicision();
  
  //ボールとブロック
  boolean schange = true;
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      schange = schange && blocks[i][j].dicision(schange);
    }
  }
  println(schange);
}

//描画用関数
void drawing(){
  background(255);
  
  //ブロック
  fill(0, 250, 255);
  stroke(1);
  for(int i = 0; i < bhn; i++){
    for(int j = 0; j < bwn; j++){
      blocks[i][j].drawer();
    }
  }
  
  //ボールとバー
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
    balv.x *= -1;
  }
  if(balx > width - balr/2){
    balx = width - balr/2;
    balv.x *= -1;
  }
  if(baly < balr/2){
    baly = balr/2;
    balv.y *= -1;
  }
  
  //ボールとバーのあたり判定
  if(balx > barx - barw/2 && balx < barx + barw/2){
    if(baly + balr/2 > bary - barh/2 && baly - balr/2 < bary + barh/2){
      baly = bary - barh/2 - balr/2;
      balv.y *= -1;
    }
  }
}

//スペースキーを押したらスタート
void keyPressed(){
  if(key == ' ')  start = true;
}
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  
  