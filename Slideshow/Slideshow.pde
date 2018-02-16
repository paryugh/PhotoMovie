/***
 * スライドショー
 * TODO:グローバル変数はXMLから読み込む
 * TODO:ユーザ設定の追加
 *      →画面サイズ（解像度）
 *      →写真の場所
 *      →写真フレームの指定
 *      →写真の大きさ設定
 * TODO:向き設定→上下左右
 * TODO:写真の読み込み順を時系列順にする。
 * TODO:ムービーの最初と最後にもメッセージを付けれるように！
 * ****** 仕様 ******
 * 会場のスクリーンサイズ（解像度）を事前に聞いておく。
 * その解像度が基準となり、フルスクリーン実行されます。
 * 小さければ余白が生まれます。大きければはみ出します。
 ***/

import java.io.*;

// フォント
PFont mono;

Background bg;
ArrayList<Photo> photoList;
ArrayList<String> photoFileList;
int photoCounter;

String imgDirectoryPath = "C:\\Users\\fj0170hx\\Documents\\Processing\\PhotoMovie\\Slideshow\\data\\写真";
String framePath = "C:\\Users\\fj0170hx\\Documents\\Processing\\PhotoMovie\\Slideshow\\data\\フォトフレーム\\28347.png";
// 対応している拡張子
String[] extensions = { 
  ".jpg", ".gif", ".tga", ".png"
};

boolean isStart = false;
float speed = 5;
int scrollMode = 2; // 1:下、2:右、3:上、4:左

void setup()
{
  /***** 画面設定 ここから *****/
  size(640, 400);
  //fullScreen();
  background(0, 0, 0);
  /***** 画面設定 ここまで *****/

  /***** 変数の初期化 ここから *****/
  bg = new Background("winter_vect-5-3.png", scrollMode);
  photoList = new ArrayList<Photo>();
  photoFileList = new ArrayList<String>();

  photoCounter = 0;
  
  mono = createFont("MicrosoftJhengHeiBold",48,true);
  /***** 変数の初期化 ここまで *****/

  // 画像ディレクトリの読み込み
  loadImageFiles(imgDirectoryPath);
}

void draw()
{
  println(frameRate);
  if (isStart)
  {
    // 背景の描画
    bg.display();
    bg.update();

    // 表示されている写真がなければ表示する！
    if (photoList.size() < 1 )
    {
      createPhoto();
      addPhoto();
    }

    for ( int i=0; i<photoList.size(); i++ )
    {
      Photo ph = photoList.get(i);
      ph.display();
      ph.update();
      if (ph.isDisplayNextPhoto())
      {
        // 次のフォトがある場合、
        if (addPhoto())
          ph.isNextPhotoDisplaied = true;
      }
      if (ph.isGoneOut())
      {
        if (ph.isNextPhotoDisplaied)
        {
          ph = null;
          photoList.remove(ph);
        } else
        {
          // 終了
          ph = null;
          photoList.remove(ph);
          delay(1000);
          exit();
        }
      }
    }
  } else 
  {
    // TODO:ロード画面を表示する。→そのために、画像読み込みは別スレッド？
  }
}

/*****
 * 画像
 *****/
void loadImageFiles(String imgDirectoryPath)
{
  File imgDirectory = new File(imgDirectoryPath);
  File[] fileArray = imgDirectory.listFiles();
  // 以下、各ファイルについて操作を行う
  for (int i = 0; i < fileArray.length; i++) {
    for (String extension : extensions) {
      {
        String fileName = fileArray[i].getAbsolutePath();
        if (fileName.endsWith(extension)) {
          println(fileName);
          photoFileList.add(fileName);
        }
      }
    }
  }
  isStart = true;
}

Photo nextPhoto = null;

/*****
 * 写真オブジェクトを生成
 *****/
boolean createPhoto()
{
  if ( photoCounter < photoFileList.size() )
  {
    String photoFileName = photoFileList.get(photoCounter);
    // photoList.add(new Photo(photoFileName, framePath, scrollMode));
    nextPhoto = new Photo(photoFileName, framePath, scrollMode);
    photoCounter++;
    return true;
  } else
  {
    //println("追加するフォトがありません。");
    return false;
  }
}

/*****
 * 写真を新しく追加する。
 *****/
boolean addPhoto()
{
  if(nextPhoto == null)
    return false;
  if( photoList.size() > 0 && nextPhoto == photoList.get(photoList.size()-1))
    return false;
  photoList.add(nextPhoto);
  // 次の写真を読み込んでおく
  thread("createPhoto");
  return true;
}

void mouseClicked() {
  if( speed > 0)
    speed = 0;
  else
    speed = 1;
}