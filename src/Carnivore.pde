class Carnivore extends Cell {

  float locationx;
  float locationy;
  float r;
  float distance;

  Carnivore(float temp_x, float temp_y) {
    this.locationx = temp_x;
    this.locationy = temp_y;
    r = 100;
  }
  void display() {
    fill(255);
    circle(locationx, locationy, r);
  }
  
  void move(){
    locationx+=random(-10,10);
    locationy+=random(-10,10);
  }
  
  boolean collide(float _x, float _y, float _r){
    distance = dist(locationx,locationy,_x,_y);
    if(distance < r/2){
      return true;
    }else{
      return false;
    }
  }
}
