class Food {

  float locationx;
  float locationy;
  int energyAmount;
  float r;
  float distance;

  Food(float temp_x, float temp_y) {
    this.locationx = temp_x;
    this.locationy = temp_y;
    r = 10;
  }
  void display() {
    noFill();
    fill(255);
    circle(locationx, locationy, r);
  }

  boolean collide(float _x, float _y, float _r) {
    distance = dist(locationx, locationy, _x, _y);
    if (distance < _r) {
      return true;
    } else {
      return false;
    }
  }
}
