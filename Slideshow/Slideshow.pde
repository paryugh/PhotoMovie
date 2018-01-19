/***
 * スライドショー
 * TODO:ユーザ設定の追加
 *      →画面サイズ（解像度）
 *      →写真の場所
 *      →写真フレームの指定
 *      →写真の大きさ設定
 * TODO:向き設定→上下左右
 ***/

Background bg;
Photo ph;
int speed;

void setup()
{
  size(640,400);
  background(0,0,0);
  bg = new Background();
  ph = new Photo("写真1.png");
}

void draw()
{
  println(frameRate);
  // 背景の描画
  bg.display();
  bg.update();
  
  // 写真の追加
  ph.display();
  ph.update();
  if(ph.isGoneOut())
  {
    ph = new Photo("写真2.png");
  }
}

class Photo
{
  // TODO:縦横比はある程度ランダムに
  // TODO:縦スクロールの場合は横幅調整、横スクロールの場合は縦幅調整
  PImage photo; // 写真画像
  PImage frame; // 写真のフレーム画像
  int photoX;
  int photoY;
  int photoW = width / 2;
  int photoH;
  
  boolean goOut;
  
  Photo(String filename)
  {
    photo = loadImage(filename);
    int ratio = photoW / photo.width;
    photoH = photo.height * ratio;
    photo.resize(photoW, photoH);
    
    float minX = 0.0;
    float maxX = width - photo.width;
    photoX = (int)random(minX, maxX);
    photoY = height;
    
    goOut = false;
    
    // フレーム画像の読み込み
    // フレーム画像は設定されている場合のみ
  }
  
  void display()
  {
    image(photo, photoX, photoY);
  }
  
  void update()
  {
    photoY--;
    println("photoH:"+photoH);
    if(photoY < -photoH)
    {
      goOut = true;
    }
  }
  
  boolean isGoneOut()
  {
    return goOut;
  }
}