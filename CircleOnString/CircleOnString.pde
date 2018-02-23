// フォント
PFont mono;

void setup()
{
  size(250, 250);
  background(255);
  
  mono = createFont("MicrosoftJhengHeiBold", 20, true);

  textInRect("Congratulation!! ほげほげだよ～ん。", 10, 10, 20);
}

void textInRect (String text, int x, int y, int textSize)
{
  textFont(mono, textSize);
  float textWidth = textWidth(text);
  float textPixel = (float)textSize * 4.0 / 3.0;
  fill(0);
  text(text, x, y + textSize);
  noFill();
  stroke(0);
  rect(x, y, textWidth, textPixel);
}