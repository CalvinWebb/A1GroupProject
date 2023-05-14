//class Herbivore extends Cell {

//  float locationx;
//  float locationy;
//  float r;
//  float distance;
//  float speed;
//  float beforeEat;
//  float afterEat;
//  float input;
//  ArrayList <Float>Smartmess=new ArrayList<Float>();

//  Herbivore(float temp_x, float temp_y, float[][] input_wih, float[][] input_who, float temp_input) {
//    super(temp_x, temp_y, input_wih, input_who, temp_input);
//    this.input = temp_input;
//    this.locationx = temp_x;
//    this.locationy = temp_y;
//    r = 50;
//  }
//  void display() {
//    fill(143, 248, 137);
//    circle(super.locationx, super.locationy, r);
//  }

//  boolean collide(float _x, float _y, float _r) {
//    distance = dist(super.locationx, super.locationy, _x, _y);
//    if (distance < r/2) {
//      return true;
//    } else {
//      return false;
//    }
//  }
  
//  void updateINP(){
//      input = distanceTo(this);
//  }
//  void onEdge(){
//    if((super.locationx+(r/2) > width) || (super.locationx-(r/2) < 0) || (super.locationy+(r/2)>height) || (super.locationy-(r/2)<0)) {
//          System.out.println("evan");
//          this.rotation += 180;
//          this.update_rotation();
//          this.updateINP();
//          this.think();
//        }
//  }
//}
