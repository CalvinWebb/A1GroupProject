class Food {

  float locationx;
  float locationy;
  int energyAmount;

  Food(float temp_x, float temp_y) {
    this.locationx = temp_x;
    this.locationy = temp_y;
  }
  void display() {
    fill(255);
    circle(locationx, locationy, 10);
  }
}
