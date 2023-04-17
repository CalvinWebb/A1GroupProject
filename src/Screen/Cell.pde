class Cell {
  float rotation = 0;
  float locationx, locationy;
  double speed;
  double cellSize; //this is just the visual representation of health
  color cellColor;
  float intelligence;
  
  //boolean hat = false;

  //Cell(float x, float y ) {
  //  locationx=x;
  //  locationy=y;
  //}

  void think() {
  }

  void update_rotation() {
  }

  void update_speed() {
    //velocity +=
  }

  void update_pos() {
    double tempx;
    double tempy;
    tempx = speed* cos(radians(rotation)) * .05;
    tempy = speed* sin(radians(rotation)) * .05;
    locationx += tempx;
    locationy +=tempy;
  }
}
//}

//weights newGen() {

//}

//int eat() {
//look at food energy to see how grow
//}
