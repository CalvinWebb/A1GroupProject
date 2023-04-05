class Carnivore extends Cell {

  float locationx;
  float locationy;
  float r;
  float distance;
  float speed;

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
    speed=(3300)/(pow(r,1.1));
    locationx+=cos(rotationAngle);
    locationy+=sin(rotationAngle);
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
