/***
 * スライドショー
 * TODO:ユーザ設定の追加
 *      →画面サイズ（解像度）
 *      →写真の場所
 *      →写真フレームの指定
 *      →写真の大きさ設定
 * TODO:向き設定→上下左右
 * TOTO:写真の読み込み順を時系列順にする。
 ***/

import java.io.*;

Background bg;
ArrayList<Photo> photoList;
ArrayList<String> photoFileList;
int photoCounter;

String imgDirectoryPath = "C:\\Users\\fj0170hx\\Documents\\Processing\\PhotoMovie\\Slideshow\\data\\写真";
// 対応している拡張子
String[] extensions = { 
  ".jpg", ".gif", ".tga", ".png"
};

boolean isStart = false;
int speed;
int scrollMode = 2; // 1:下、2:右、3:上、4:左

void setup()
{
  /***** 画面設定 ここから *****/
  size(640, 400);
  background(0, 0, 0);
  /***** 画面設定 ここまで *****/

  /***** 変数の初期化 ここから *****/
  bg = new Background("winter_vect-5-3.png", scrollMode);
  photoList = new ArrayList<Photo>();
  photoFileList = new ArrayList<String>();

  photoCounter = 0;
  /***** 変数の初期化 ここまで *****/

  // 画像ディレクトリの読み込み
  loadImageFiles(imgDirectoryPath);
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
      if (ph.isDisplayNextPhoto())
      {
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

/*****
 * 写真を新しく追加する。
 *****/
boolean addPhoto()
{
  if ( photoCounter < photoFileList.size() )
  {
    String photoFileName = photoFileList.get(photoCounter);
    photoList.add(new Photo(photoFileName, scrollMode));
    photoCounter++;
    return true;
  } else
  {
    //println("追加するフォトがありません。");
    return false;
  }
}