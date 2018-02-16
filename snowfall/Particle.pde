float MIN_PARTICLE_DIAMETER = 70;
float MAX_PARTICLE_DIAMETER = 100;
float MAX_PARTICLE_VELOCITY_X = 0.5;
float MAX_PARTICLE_VEL_VARIANT_X = 0.1;
float MAX_PARTICLE_VELOCITY_Y = 1.0;
float MAX_PARTICLE_VEL_VARIANT_Y = 0.1;
//float MAX_BLINK_SPEED = PI / 128.0;

class Particle{
  
  PVector loc, vel;
  float blinkAngle;
  
  Particle(){
    loc = new PVector(random(width), height + MAX_PARTICLE_DIAMETER / 2);
    vel = new PVector(random(-MAX_PARTICLE_VELOCITY_X, MAX_PARTICLE_VELOCITY_X), random(MAX_PARTICLE_VELOCITY_Y));
    blinkAngle = random(100);
  }
  
  void display(){
    float diameter = map(sin(blinkAngle), -1, 1, MIN_PARTICLE_DIAMETER, MAX_PARTICLE_DIAMETER);
    //for(float v = 1.0; v >= 0.0; v -= 0.2){
      float v = 1.0;
      float d = map(v, 0, 1, 0, diameter);
      float r = map(pow(v, 5), 0, 1, 255, 128);
      float g = map(pow(v, 5), 0, 1, 255, 255);
      float b = map(pow(v, 5), 0, 1, 255, 255);
      fill(r, g, b, 30);
      ellipse(loc.x, loc.y, d, d);
    //}
  }
  
  void update(){
    vel.x += random(-MAX_PARTICLE_VEL_VARIANT_X, MAX_PARTICLE_VEL_VARIANT_X);
    vel.x = constrain(vel.x, -MAX_PARTICLE_VELOCITY_X, MAX_PARTICLE_VELOCITY_X);
    vel.y += random(-MAX_PARTICLE_VEL_VARIANT_Y, MAX_PARTICLE_VEL_VARIANT_Y);
    vel.y = constrain(vel.y, 0, MAX_PARTICLE_VELOCITY_Y);
    // 上へ
    loc.sub(vel);
    //blinkAngle += random(MAX_BLINK_SPEED);
    //if(blinkAngle >= TWO_PI){
    //  blinkAngle -= TWO_PI;
    //}
  }
  
  boolean isGoneOut(){
    return loc.y < 0 - MAX_PARTICLE_DIAMETER / 2; // loc.y > height + MAX_PARTICLE_DIAMETER / 2;
  }
  
}