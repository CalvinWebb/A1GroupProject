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
    super();
    this.locationx = temp_x;
    this.locationy = temp_y;
    r = 50;
  }
  void display() {
    fill(248, 143, 137);
    circle(locationx, locationy, r);
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
