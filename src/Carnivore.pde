class Carnivore extends Cell {

  float locationx;
  float locationy;

  Carnivore(float temp_x, float temp_y) {
    this.locationx = temp_x;
    this.locationy = temp_y;
  }
  void display() {
    fill(255);
    circle(locationx, locationy, 100);
  }
  
  void move(){
    pushMatrix();
    translate(random(-5,5),random(-5,5));
    popMatrix();
  }
}
