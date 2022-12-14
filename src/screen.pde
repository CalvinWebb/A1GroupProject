
boolean play;
void setup() {
  size(1000, 1000);
  boolean play = false;
}
void draw () {
  background (0);

  if (!play) {
    startScreen();
  } else {//do things
  }
}
void startScreen() {
  background (0);
  textAlign(CENTER);
  fill(255);
  textSize(46);
  text("Click Anywhere to Start", width/2, height/2-100);
  //button would replace after textAlign
  if (mousePressed) {
    play=true;
  }
}
void mousePressed() {
}
