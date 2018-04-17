// フォント
PFont mono;

void setup()
{
  size(600, 400);
  background(255);

  mono = createFont("MicrosoftJhengHeiBold", 20, true);
  
  int textSize = 30;
  String text = "Congratulation!! ほげほげだよ～ん。";
  Ellipse myEllipse = new Ellipse((float)width/2.0, (float)height/2.0, (float)height);
  Rect myRect = rectIntoEllipse(myEllipse.x, myEllipse.y, myEllipse.diameter);
  
  String[] multiLineText = textSpliter(text, myRect.w, myRect.h, textSize);
  
  PVector textVector = textIntoEllipse(myRect.x, myRect.y, myRect.w, myRect.h, multiLineText.length, textSize, CENTER, BOTTOM);
  
  for (int i=0; i<multiLineText.length; i++)
  {
    text(multiLineText[i], textX, textY);
    textY += textSize;
  }
  
  fill(0);
  textAlign(align, vertical);
  noFill();
  stroke(0);
  textAlign(align, vertical);
  ellipse(x, y, diameter, diameter);
  rect(rextX, rextY, rectSize, rectSize);
}

/*****
 * 円に内包する正方形を取得して座標を返却
 *****/
public Rect rectIntoEllipse(float x, float y, float diameter)
{
  Rect myRect = new Rect();
  float rectSize = diameter / sqrt(2);
  float rectPosition = (diameter - rectSize) / 2.0;
  myRect.x = x - diameter/2.0 + rectPosition;
  myRect.y = y - diameter/2.0 + rectPosition;
  myRect.w = rectSize;
  myRect.h = rectSize;
  return myRect;
}

// 円の中に文字列を表示する。
// はみ出す場合は文字列をカット
public PVector textIntoEllipse(float x, float y, float w, float h, int textLength, int textSize, int align, int vertical)
{
  float textX = rextX;
  float textY = rextY;

  switch(align)
  {
  case LEFT :
    textX = rextX;
    break;
  case CENTER :
    textX = x;
    break;
  case RIGHT :
    textX = rextX + rectSize;
    break;
  default :
    break;
  }
  switch(vertical)
  {
  case TOP :
    textY = rextY;
    break;
  case CENTER :
    textY = y + textSize * (multiLineText.length / 2.0 - 0.5 - ( multiLineText.length - 1 ));
    break;
  case BOTTOM :
    textY = rextY + rectSize - textSize * (multiLineText.length - 1);
    break;
  default :
    break;
  }
  
  return new PVector(x-textX, y-textY);
}

// 文字を分割する。
public String[] textSpliter(String text, float w, float h, int textSize)
{
  //println("w:" + w);
  //println("h:" + h);
  textFont(mono, textSize);

  float textWidth = textWidth(text);
  float textHeight = (float)textSize * 4.0 / 3.0;
  //println("textHeight:" + textHeight);

  int line = 1;
  ArrayList<String> multiLineText = new ArrayList<String>();

  if (textWidth > w)
  {
    // テキストの分割
    //println(textWidth/w);
    // for でクルクル回して 分割文字を挿入する。
    char[] textChars = text.toCharArray();
    StringBuilder sb = new StringBuilder();
    for ( int i=0; i<textChars.length; i++ )
    {
      sb.append(textChars[i]);
      //print(textChars[i]);
      if (textWidth(sb.toString()) > w)
      {
        sb.delete((int)sb.length()-1, (int)sb.length());
        multiLineText.add(sb.toString());

        // 縦がはみ出すときは強制終了
        line ++;
        //println( textHeight + " * " + line + " > " + h);
        if ( textHeight * line > h )
        {
          break;
        }

        sb = new StringBuilder();
        sb.append(textChars[i]);
        //println();
        //println("---------------------------");
      }
    }
    multiLineText.add(sb.toString());
  }

  String[] str = new String[multiLineText.size()];
  return multiLineText.toArray(str);
}

// 四角形の中に文字列を表示する。
// はみ出す場合は文字列をカット
void textInRect (String text, float x, float y, float w, float h, int textSize)
{
  String[] multiLineText = textSpliter(text, w, h, textSize);

  fill(0);
  float textY = y;
  for (int i=0; i<multiLineText.length; i++)
  {
    textY += textSize;
    text(multiLineText[i], x, textY);
  }
  noFill();
  stroke(0);
  rect(x, y, w, h);
}