
class Photo
{
  // TODO:縦横比はある程度ランダムに
  // TODO:縦スクロールの場合は横幅調整、横スクロールの場合は縦幅調整
  // TODO:フレーム画像は複数あってもいいかも？
  // TODO:メッセージを追加
  PImage photo; // 写真画像
  PImage frame = null; // 写真のフレーム画像
  float photoX;
  float photoY;
  float photoW;
  float photoH;
  float photoSpaceW = 50;
  float photoSpaceH = 100; // 高さ TODO:高さに合わせて写真サイズ・メッセージサイズを変える？
  boolean isRandom = false; // 写真の高さがランダムかどうか
  float photoSizeRaito = 2.0/3.0;

  int scrollMode = 1;

  boolean goOut;
  boolean goIn;
  boolean isNextPhotoDisplaied;

  String message = "";
  float messageSize = 50;
  int fontsize = 28;

  Photo(String filename, int _scrollMode)
  {
    photo = loadImage(filename);

    scrollMode = _scrollMode;

    init();

    // フレーム画像の読み込み
    // フレーム画像は設定されている場合のみ
  }

  Photo(String filename, String photoFrame, int _scrollMode)
  {
    this(filename, _scrollMode);
    // フレームの読み込み
    if (!photoFrame.isEmpty())
    {
      frame = loadImage(photoFrame);
      frame.resize((int)photoW, (int)photoH);
    }
  }

  Photo(String filename, String photoFrame, int _scrollMode, String _message)
  {
    this(filename, photoFrame, _scrollMode);
    message = _message;
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
    println("==========");
    println("photoraito"+photoSizeRaito);
    println("W"+photoW);
    println("H"+photoH);
    println(photo.width);
    println(photo.height);
    println(ratio);
    println("==========");

    // その他初期化処理
    goOut = false;
    goIn = false;
    isNextPhotoDisplaied = false;
  }

  // 写真を表示するメソッド
  void display()
  {
    image(photo, photoX, photoY);
    if (frame!=null)
      image(frame, photoX, photoY);
    if (!message.isEmpty())
    {
      fill(0);
      rect(photoX, photoY + photo.height, photo.width, messageSize);
      textSize(32);
      fill(0, 102, 153);
      textFont(mono);
      text(message, photoX, photoY + photo.height, photoX + photo.width, photoY + messageSize);
    }
  }

  // 写真を動かすメソッド
  void update()
  {
    switch(scrollMode)
    {
    case 1 :
      photoY -= speed;
      if (photoY < -photoH)
      {
        goOut = true;
      }
      if (photoY < height - photoH - photoSpaceW)
      {
        goIn = true;
      }
      break;
    case 2 :
      photoX -= speed;
      if (photoX < -photoW)
      {
        goOut = true;
      }
      if (photoX < width - photoW - photoSpaceW)
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