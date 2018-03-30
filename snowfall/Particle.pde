float MIN_PARTICLE_DIAMETER = 700;
float MAX_PARTICLE_DIAMETER = 900;
float MAX_PARTICLE_VELOCITY_X = 1.0;
float MAX_PARTICLE_VEL_VARIANT_X = 0.1;
float MAX_PARTICLE_VELOCITY_Y = 2.0;
float MAX_PARTICLE_VEL_VARIANT_Y = 2.0;
//float MAX_BLINK_SPEED = PI / 128.0;

class Particle {

  PVector loc, vel;
  float blinkAngle;


  Particle() {
    loc = new PVector(random(width), height + MAX_PARTICLE_DIAMETER / 2);
    vel = new PVector(random(-MAX_PARTICLE_VELOCITY_X, MAX_PARTICLE_VELOCITY_X), random(MAX_PARTICLE_VELOCITY_Y));
    blinkAngle = random(0.0, 1.0);


    println(width + ":" + MIN_PARTICLE_DIAMETER + "," + MAX_PARTICLE_DIAMETER);
  }

  void display() {
    float diameter = map(sin(blinkAngle), 0, 1, MIN_PARTICLE_DIAMETER, MAX_PARTICLE_DIAMETER);
    //for(float v = 1.0; v >= 0.0; v -= 0.2){
    float v = 1.0;
    float d = map(v, 0, 1, 0, diameter);
    float r = map(pow(v, 5), 0, 1, 255, 128);
    float g = map(pow(v, 5), 0, 1, 255, 255);
    float b = map(pow(v, 5), 0, 1, 255, 255);
    fill(r, g, b, 30);
    ellipse(loc.x, loc.y, d, d);

    // TODO : この辺りは固定？
    int textSize = 20;
    float rectSize = d / sqrt(2);
    String text = "hogehogehogehoge";
    String[] multiLineText = textSpliter(text, rectSize, rectSize, textSize);
    
    float rectPosition = (d - rectSize) / 2.0;
    float rextX = loc.x - d/2.0 + rectPosition;
    float textY = loc.y - d/2.0 + rectPosition;
    println("z:"+rextX+","+textY);
    fill(255);
    textFont(mono, textSize);
    textAlign(CENTER, CENTER);
    text("hogehoge", rextX, textY);
    for (int i=0; i<multiLineText.length; i++)
    {
      textY += textSize;
      text(multiLineText[i], rextX, textY);
    }
    //}
  }

  void update() {
    vel.x += random(-MAX_PARTICLE_VEL_VARIANT_X, MAX_PARTICLE_VEL_VARIANT_X);
    vel.x = constrain(vel.x, -MAX_PARTICLE_VELOCITY_X, MAX_PARTICLE_VELOCITY_X);
    vel.y += MAX_PARTICLE_VELOCITY_Y; //random(-MAX_PARTICLE_VEL_VARIANT_Y, MAX_PARTICLE_VEL_VARIANT_Y);
    vel.y = constrain(vel.y, 0, MAX_PARTICLE_VELOCITY_Y);
    // 上へ
    loc.sub(vel);
    //blinkAngle += random(MAX_BLINK_SPEED);
    //if(blinkAngle >= TWO_PI){
    //  blinkAngle -= TWO_PI;
    //}
  }

  boolean isGoneOut() {
    return loc.y < 0 - MAX_PARTICLE_DIAMETER / 2; // loc.y > height + MAX_PARTICLE_DIAMETER / 2;
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
      println(textWidth/w);
      // for でクルクル回して 分割文字を挿入する。
      char[] textChars = text.toCharArray();
      StringBuilder sb = new StringBuilder();
      for ( int i=0; i<textChars.length; i++ )
      {
        sb.append(textChars[i]);
        if (textWidth(sb.toString()) > w)
        {
          sb.delete((int)sb.length()-1, (int)sb.length());
          multiLineText.add(sb.toString());

          // 縦がはみ出すときは強制終了
          line ++;
          println( textHeight + " * " + line + " > " + h);
          if ( textHeight * line > h )
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
}