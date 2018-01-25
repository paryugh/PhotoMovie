
class Photo
{
  // TODO:縦横比はある程度ランダムに
  // TODO:縦スクロールの場合は横幅調整、横スクロールの場合は縦幅調整
  // TODO:もし、写真が拡大される場合は原寸表示する。
  PImage photo; // 写真画像
  PImage frame; // 写真のフレーム画像
  float photoX;
  float photoY;
  float photoW = width / 2;
  float photoH;
  float photoSpace = 50;

  boolean goOut;
  boolean goIn;
  boolean isNextPhotoDisplaied;

  Photo(String filename)
  {
    photo = loadImage(filename);
    float ratio = photoW / photo.width;
    photoH = photo.height * ratio;
    println("==========");
    println("W"+photoW);
    println("H"+photoH);
    println(photo.width);
    println(photo.height);
    println(ratio);
    println("==========");
    photo.resize((int)photoW, (int)photoH);

    float minX = 0.0;
    float maxX = width - photo.width;
    photoX = random(minX, maxX);
    photoY = height;

    goOut = false;
    goIn = false;
    isNextPhotoDisplaied = false;

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
    if (photoY < -photoH)
    {
      goOut = true;
    }
    if (photoY < height - photoH - photoSpace)
    {
      goIn = true;
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
    if( !isNextPhotoDisplaied )
    {
      return goIn;
    }
    else
    {
      return false;
    }
  }
}