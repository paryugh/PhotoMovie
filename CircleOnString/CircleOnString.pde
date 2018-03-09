// フォント
PFont mono;

void setup()
{
  size(600, 250);
  background(255);
  
  mono = createFont("MicrosoftJhengHeiBold", 20, true);

  //textInRect("Congratulation!! ほげほげだよ～ん。", 10.0, 10.0, 100.0, 80.0, 20);
  textInEllipse("Congratulation!! ほげほげだよ～ん。", 300.0, 125.0, 200.0, 20);
}

// 四角形の中に文字列を表示する。
// はみ出す場合は文字列をカット
void textInRect (String text, float x, float y, float w, float h, int textSize)
{
  String[] multiLineText = textSpliter(text, w, h, textSize);
  
  fill(0);
  float textY = y;
  for(int i=0; i<multiLineText.length; i++)
  {
    textY += textSize;
    text(multiLineText[i], x, textY);
  }
  noFill();
  stroke(0);
  rect(x, y, w, h);
}

// 円の中に文字列を表示する。
// はみ出す場合は文字列をカット
public void textInEllipse(String text, float x, float y, float diameter, int textSize)
{
  float rectSize = diameter / sqrt(2);
  float rectPosition = (diameter - rectSize) / 2.0;
  float rextX = x - diameter/2.0 + rectPosition;
  float rextY = y - diameter/2.0 + rectPosition;
  
  String[] multiLineText = textSpliter(text, rectSize, rectSize, textSize);
  
  fill(0);
  float textY = rextY;
  for(int i=0; i<multiLineText.length; i++)
  {
    textY += textSize;
    text(multiLineText[i], rextX, textY);
  }
  noFill();
  stroke(0);
  ellipse(x, y, diameter, diameter);
  rect(rextX, rextY, rectSize, rectSize);
}

// 文字を分割する。
public String[] textSpliter(String text, float w, float h, int textSize)
{
  println("w:" + w);
  println("h:" + h);
  textFont(mono, textSize);
  
  float textWidth = textWidth(text);
  float textHeight = (float)textSize * 4.0 / 3.0;
  println("textHeight:" + textHeight);
  
  int line = 1;
  ArrayList<String> multiLineText = new ArrayList<String>();
  
  if(textWidth > w)
  {
    // テキストの分割
    println(textWidth/w);
    // for でクルクル回して 分割文字を挿入する。
    char[] textChars = text.toCharArray();
    StringBuilder sb = new StringBuilder();
    for( int i=0; i<textChars.length; i++ )
    {
      sb.append(textChars[i]);
      if(textWidth(sb.toString()) > w)
      {
        sb.delete((int)sb.length()-1, (int)sb.length());
        multiLineText.add(sb.toString());
        
        // 縦がはみ出すときは強制終了
        line ++;
        println( textHeight + " * " + line + " > " + h);
        if( textHeight * line > h )
        {
          break;
        }
        
        sb = new StringBuilder();
        sb.append(textChars[i]);
      }
    }
  }
  
  String[] str = new String[multiLineText.size()];
  return multiLineText.toArray(str);
}