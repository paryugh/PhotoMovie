
class Photo
{
  // TODO:縦横比はある程度ランダムに
  // TODO:縦スクロールの場合は横幅調整、横スクロールの場合は縦幅調整
  // TODO:もし、写真が拡大される場合は原寸表示する。
  // TODO:フレーム画像を読み込む。
  // TODO:フレーム画像は複数あってもいいかも？
  PImage photo; // 写真画像
  PImage frame; // 写真のフレーム画像
  float photoX;
  float photoY;
  float photoW;
  float photoH;
  float photoSpace = 50;
  float photoSizeRaito = 2.0/3.0;

  int scrollMode = 1;

  boolean goOut;
  boolean goIn;
  boolean isNextPhotoDisplaied;

  Photo(String filename, int _scrollMode)
  {
    photo = loadImage(filename);
    
    scrollMode = _scrollMode;

    init();

    // フレーム画像の読み込み
    // フレーム画像は設定されている場合のみ
  }

  // 初期化処理
  void init()
  {
    float ratio = 0.0;
    float min = 0.0;
    float max = 0.0;

    // 写真の初期化
    switch(scrollMode)
    {
    case 1 :
      // 写真のサイズが小さい場合は、小さいまま表示する。
      photoW = (float)width * photoSizeRaito;
      if ( photoW >= (float)photo.width )
        photoW = (float)photo.width;
      ratio = photoW / (float)photo.width;
      photoH = (float)photo.height * ratio;
      photo.resize((int)photoW, (int)photoH);

      min = 0.0;
      max = width - photo.width;
      photoX = random(min, max);
      photoY = height;
      break;
    case 2 :
      // 写真のサイズが小さい場合は、小さいまま表示する。
      photoH = (float)height * photoSizeRaito;
      if ( photoH >= (float)photo.height )
        photoH = (float)photo.height;
      ratio = photoH / (float)photo.height;
      photoW = (float)photo.width * ratio;
    println("==========");
    println("photoraito"+photoSizeRaito);
    println("W"+photoW);
    println("H"+photoH);
    println(photo.width);
    println(photo.height);
    println(ratio);
    println("==========");
      photo.resize((int)photoW, (int)photoH);

      min = 0.0;
      max = height - photo.height;
      photoX = width;
      photoY = random(min, max);
      break;
    case 3 :
    case 4 :
    default:
      break;
    }

    // その他初期化処理
    goOut = false;
    goIn = false;
    isNextPhotoDisplaied = false;
  }

  // 写真を表示するメソッド
  void display()
  {
    image(photo, photoX, photoY);
  }

  // 写真を動かすメソッド
  void update()
  {
    switch(scrollMode)
    {
    case 1 :
      photoY--;
      if (photoY < -photoH)
      {
        goOut = true;
      }
      if (photoY < height - photoH - photoSpace)
      {
        goIn = true;
      }
      break;
    case 2 :
      photoX--;
      if (photoX < -photoW)
      {
        goOut = true;
      }
      if (photoX < width - photoW - photoSpace)
      {
        goIn = true;
      }
      break;
    case 3 :
    case 4 :
    default:
      break;
    }
  }

  boolean isGoneOut()
  {
    return goOut;
  }

  /*****
   * 画像が枠内に入っていれば true 
   * それ以外は false
   * 写真間隔が指定されていれば、それも考慮する。
   *****/
  boolean isDisplayNextPhoto()
  {
    if ( !isNextPhotoDisplaied )
    {
      return goIn;
    } else
    {
      return false;
    }
  }
}