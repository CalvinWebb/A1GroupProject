class Carnivore extends Cell {

  float locationx;
  float locationy;
  float r;
  float distance;
  float speed;
  float beforeEat;
  float afterEat;
  ArrayList <Float>Smartmess=new ArrayList<Float>();

  Carnivore(float temp_x, float temp_y) {
    this.locationx = temp_x;
    this.locationy = temp_y;
    r = 50;
  }
  void display() {
    fill(248, 143, 137);
    circle(locationx, locationy, r);
  }

  void move() {
    speed=(20)/sqrt(sqrt(r));
    if (((locationx+r/2) > width||(locationx-r/2)<0)||(locationy-r/2)<0||(locationy+r/2)>height) {
 
      rotation+= random(3*PI/4,5*PI/4);
      r -= 4096/(r*r);
    }
      locationx+=speed*cos(rotation);
      locationy+=speed*sin(rotation);
  }

  boolean decision() {
    if (Smartmess.get(Smartmess.size()-1) - Smartmess.get(Smartmess.size()-2) <= 0 - Smartmess.get(Smartmess.size()-3)) {
      return false;
    }
    return true;
  }

  boolean collide(float _x, float _y, float _r) {
    distance = dist(locationx, locationy, _x, _y);
    if (distance < r/2) {
      return true;
    } else {
      return false;
    }
  }
  
  void recursion(){
    
  }
}
