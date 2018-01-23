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
ArrayList<Photo> photoList;
ArrayList<String> photoFileList;
int photoCounter;

String[] extensions = { //操作したいファイルの拡張子を登録
  ".jpg", ".gif", ".tga", ".png"
};

boolean isStart = false;
int speed;

void setup()
{
  /***** 画面設定 ここから *****/
  size(640, 400);
  background(0, 0, 0);
  /***** 画面設定 ここまで *****/

  /***** 変数の初期化 ここから *****/
  bg = new Background();
  photoList = new ArrayList<Photo>();
  photoFileList = new ArrayList<String>();
  
  photoCounter = 0;
  /***** 変数の初期化 ここまで *****/

  //photoList.add(new Photo("写真1.png"));
  selectFolder("ファイルを指定してください", "loadImages");
}

void draw()
{
  //println(frameRate);
  if (isStart)
  {
    // 背景の描画
    bg.display();
    bg.update();

    // 表示されている写真がなければ表示する！
    if (photoList.size() < 1 )
    {
      addPhoto();
    }

    for ( int i=0; i<photoList.size(); i++ )
    {
      Photo ph = photoList.get(i);
      ph.display();
      ph.update();
      if (ph.isInDisplay())
      {
        addPhoto();
      }
      if (ph.isGoneOut())
      {
        ph = null;
        photoList.remove(ph);
      }
    }
  } else 
  {
    // ロード画面を表示する。
  }
}

void loadImages(File selection)
{
  File[] files = selection.listFiles();
  // 以下、各ファイルについて操作を行う
  for (int i = 0; i < files.length; i++) {
    for (String extension : extensions) {
      if (files[i].getPath().endsWith(extension)) { //ファイル名の末尾が拡張子と一致するか
        photoFileList.add(files[i].getAbsolutePath()); // 絶対パスを格納
      }
    }
  }
  isStart = true;
}

/*****
 * 写真を新しく追加する。
 *****/
boolean addPhoto()
{
  if( photoCounter < photoFileList.size() )
  {
    String photoFileName = photoFileList.get(photoCounter);
    photoList.add(new Photo(photoFileName));
    photoCounter++;
    return true;
  }
  else
  {
    //println("追加するフォトがありません。");
    return false;
  }
}