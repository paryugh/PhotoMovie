/***
 * スライドショー
 * TODO:ユーザ設定の追加
 *      →画面サイズ（解像度）
 *      →写真の場所
 *      →写真フレームの指定
 *      →写真の大きさ設定
 ***/

Background bg;

void setup()
{
  size(640,400);
  background(0,0,0);
  bg = new Background();
}

void draw()
{
  println(frameRate);
  // 背景の描画
  bg.display();
  bg.update();
  
  // 写真の追加
  
}

class Photo
{
  // 縦横比はある程度ランダムにしたいな。
  PImage p;
  int photoX;
  int photoY;
  int photoW;
  int photoH;
  Photo(String filename)
  {
    p = loadImage(filename);
  }
  
  void display()
  {
    image(p, 0, 0);
  }
  
  void update()
  {
  }
}