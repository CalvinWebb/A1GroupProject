class Carnivore extends Cell {

  float locationx;
  float locationy;
  float r;
  float distance;
  float speed;
  float beforeEat;
  float afterEat;
  float input;
  ArrayList <Float>Smartmess=new ArrayList<Float>();

  Carnivore(float temp_x, float temp_y, float[][] input_wih, float[][] input_who, float temp_input) {
    super(temp_x, temp_y, input_wih, input_who, temp_input);
    this.input = temp_input;
    this.locationx = temp_x;
    this.locationy = temp_y;
    r = 50;
  }
  void display() {
    fill(248, 143, 137);
    circle(super.locationx, super.locationy, r);
  }

  boolean collide(float _x, float _y, float _r) {
    distance = dist(locationx, locationy, _x, _y);
    if (distance < _r) {
      return true;
    } else {
      return false;
    }
  }
  
  void updateINP(){
    super.input = distanceTo(this);
  }
}
