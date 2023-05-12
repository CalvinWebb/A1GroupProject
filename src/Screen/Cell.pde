class Cell {
  float rotation;
  float locationx, locationy;
  double speed;
  double cellSize; //this is just the visual representation of health
  float[][] wih = new float[5][1];
  float[][] who = new float[5][1];
  float input;
  float[][] output = new float[5][1];
  float[][] hi = new float[5][1];
  float nn_dr;
  int fitness;

  //boolean hat = false;

  Cell(float x, float y, float[][] input_wih, float[][] input_who, float temp_input) {
    locationx=x;
    locationy=y;
    nn_dr = 0;
    rotation = random(0,360);
    // temp 100
    speed = 50;
    who = input_who;
    wih = input_wih;
    input = temp_input;
    fitness = 0;
  }

  void think() {
    
    for (int i =0; i< wih.length; i++) {
      for (int j = 0; j< wih[0].length; j++) {
        hi[i][j] = (float)Math.tanh(input * wih[i][j]);
      }
    }
    for (int k =0; k< wih.length; k++) {
      for (int l = 0; l< wih[0].length; l++) {
        output[k][l] = (float)Math.tanh(hi[k][l] * who[k][l]);
      }
    }
    for(int m = 0; m < output.length; m++){
      for(int n = 0; n < output[0].length; n++){
        nn_dr += output[m][n];
      }
    }
  }

  void update_rotation() {
    rotation += nn_dr * 180;
    rotation = rotation % 360;
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
