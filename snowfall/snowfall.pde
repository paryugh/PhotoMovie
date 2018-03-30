/**
 * snowfall
 *
 * @author aa_debdeb
 * @date 2016/08/16
 * TODO:メッセージと写真をシャボン玉に乗せることができる。
 */

// フォント
PFont mono;
float SNOW_FALL = 1.0/10.0; // 積雪量

ArrayList<Particle> particles;
ArrayList<Picture> picture;

void setup() {
  size(1600, 900); // fullScreen();
  noStroke();
  particles = new ArrayList<Particle>();
  background(0);
  mono = createFont("MicrosoftJhengHeiBold", 20, true);
}

void draw() {
  textFont(mono, 12);
  fill(255);
  text(frameRate, 10, 10);
  //println(frameRate);
  fill(0, 70);
  rect(0, 0, width, height);
  //ArrayList<Particle> nextParticles = new ArrayList<Particle>();
  for (Particle p : particles) {
    p.display();
    p.update();
    //if(!p.isGoneOut()){
    //  nextParticles.add(p);
    //}
  }
  //particles = nextParticles;
  //if(random(1) < SNOW_FALL){
  //  particles.add(new Particle());
  //}

  //rect(width/2, height/2, 50, 50);
}

void mouseClicked()
{
  particles.add(new Particle());
}