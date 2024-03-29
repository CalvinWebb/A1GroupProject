class Carnivore extends Cell {


  float r;
  float distance;
  float speed;
  float beforeEat;
  float afterEat;
  boolean canEatCell=false;
  ArrayList <Float>Smartmess=new ArrayList<Float>();

  Carnivore(float temp_x, float temp_y, float[][] input_wih, float[][] input_who, float temp_input, boolean temp_canEatCell) {
    super(temp_x, temp_y, input_wih, input_who, temp_input, temp_canEatCell);
    this.canEatCell =temp_canEatCell;
    r = 50;
  }
  void display() {
    if (canEatCell) {
      fill(248, 143, 137);
    } else {
      fill(143,248,137);
    }
    circle(super.locationx, super.locationy, r);
  }

  boolean collide(float _x, float _y, float _r) {
    distance = dist(super.locationx, super.locationy, _x, _y);
    if (distance < r/2) {
      return true;
    } else {
      return false;
    }
  }

  void updateINP() {
    super.input = distanceTo(this);
  }

  void onEdge(){
    if((super.locationx+(r/2) > width) || (super.locationx-(r/2) < 0) || (super.locationy+(r/2)>height) || (super.locationy-(r/2)<0)) {
          super.rotation += 180;
          this.updateINP();
          super.think();
          super.update_rotation();
        }
  }
}
