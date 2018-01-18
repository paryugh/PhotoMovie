/*** 
 * 背景を描画するクラス
 * TODO:背景画像が縦長なら縦スクロール、横長なら横スクロールとする。
 * TODO:縦・横スクロールは設定もできるようにする。（空白, 縦, 横）
 ***/
class Background
{
  PImage img1;
  PImage img2;
  float img1X = 0.0;
  float img1Y = 0.0;
  float img2X = 0.0;
  float img2Y = 0.0;
  
  // コンストラクタ
  Background()
  {
    // 背景画像１の読み込み
    img1 = loadImage("bluegradation.png");
    int ratio = img1.width / width;
    int imgheight = img1.height * ratio;
    img1.resize(width, imgheight);
    
    // 背景画像２の読み込み
    img2 = loadImage("bluegradation.png");
    img2.resize(width, imgheight);
    
    img2Y = img1.height;
  }
  
  void display()
  {
    image(img1, img1X, img1Y);
    image(img2, img2X, img2Y);
  }
  
  void update()
  {
    img1Y --;
    img2Y --;
    // imgY が自分の高さ分のマイナスになると、もう一つのimgの高さのところに行く
    if(img1Y < -img1.height)
    {
      img1Y = img2Y + img2.height;
    }
    if(img2Y < -img2.height)
    {
      img2Y = img1Y + img1.height;
    }
  }
}