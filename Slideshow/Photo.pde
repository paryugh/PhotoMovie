
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
  int photoSpace = 50;
  
  boolean goOut;
  
  Photo(String filename)
  {
    photo = loadImage(filename);
    int ratio = photoW / photo.width;
    photoH = photo.height * ratio;
    println("==========");
    println("W"+photoW);
    println("H"+photoH);
    println(photo.width);
    println(photo.height);
    println(ratio);
    println("==========");
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
    if(photoY < -photoH)
    {
      goOut = true;
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
  boolean isInDisplay()
  {
    if(photoY > photoH + photoSpace)
    {
      return true;
    }
    return false;
  }
}