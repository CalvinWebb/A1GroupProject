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
    r = 100;
  }
  void display() {
    fill(248, 143, 137);
    circle(locationx, locationy, r);
  }

  void move() {
    speed=(5);
    if (((locationx+r/2) > width||(locationx-r/2)<0)||(locationy-r/2)<0||(locationy+r/2)>height) {
 
      rotationAngle+=PI;
      r -= 100000/(r*r);
    }
      locationx+=speed*cos(rotationAngle);
      locationy+=speed*sin(rotationAngle);
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
