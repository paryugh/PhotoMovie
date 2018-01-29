/*** 
 * 背景を描画するクラス
 * TODO:背景画像が画面の高さに満たない場合は、読み込む背景数を増やす。→背景画像は配列に。
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

  int scrollMode = 1;

  // コンストラクタ
  Background(String pgPath, int _scrollMode)
  {
    // 背景画像１の読み込み
    img1 = loadImage(pgPath);

    // 背景画像２の読み込み
    img2 = loadImage(pgPath);

    // スクロールモード
    scrollMode = _scrollMode;

    // 初期化
    init();
  }

  void init()
  {
    float imgW = 0;
    float imgH = 0;
    float raito = 0;
    // 
    switch(scrollMode)
    {
    case 1 :
      // 背景１の縦横調整
      raito = (float)width / (float)img1.width;
      imgH = (float)img1.height * raito;
      img1.resize(width, (int)imgH);

      // 背景２の縦横調整
      img2.resize(width, (int)imgH);
      img2Y = img1.height;
      break;
    case 2 :
      // 背景１の縦横調整
      raito = (float)height / (float)img1.height;
      imgW = (float)img1.width * raito;
      img1.resize((int)imgW, height);

      // 背景２の縦横調整
      img2.resize((int)imgW, height);
      img2X = img1.width;
      break;
    case 3 :
    case 4 :
    default:
      break;
    }
  }

  void display()
  {
    image(img1, img1X, img1Y);
    image(img2, img2X, img2Y);
  }

  void update()
  {
    switch(scrollMode)
    {
    case 1 :
      img1Y --;
      img2Y --;
      // imgY が自分の高さ分のマイナスになると、もう一つのimgの高さのところに行く
      if (img1Y < -img1.height)
      {
        img1Y = img2Y + img2.height;
      }
      if (img2Y < -img2.height)
      {
        img2Y = img1Y + img1.height;
      }
      break;
    case 2 :
      img1X --;
      img2X --;
      // imgY が自分の高さ分のマイナスになると、もう一つのimgの高さのところに行く
      if (img1X < -img1.width)
      {
        img1X = img2X + img2.width;
      }
      if (img2X < -img2.width)
      {
        img2X = img1X + img1.width;
      }
      break;
    case 3 :
    case 4 :
    default:
      break;
    }
  }
}