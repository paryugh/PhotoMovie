/**
* snowfall
*
* @author aa_debdeb
* @date 2016/08/16
*/

float SNOW_FALL = 1.0/10.0; // sekisetsuryo

ArrayList<Particle> particles;
ArrayList<Picture> picture;

void setup(){
  size(640, 480); // fullScreen();
  noStroke();
  particles = new ArrayList<Particle>();
  background(0);
}

void draw(){
  fill(0, 70);
  rect(0, 0, width, height);
  ArrayList<Particle> nextParticles = new ArrayList<Particle>();
  for(Particle p: particles){
    p.display();
    p.update();
    if(!p.isGoneOut()){
      nextParticles.add(p);
    }
  }
  particles = nextParticles;
  if(random(1) < SNOW_FALL){
    particles.add(new Particle());
  }
  
  rect(width/2, height/2, 50, 50);
}