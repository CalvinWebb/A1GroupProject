import processing.sound.*;

SoundFile music;
PImage background;
boolean play;
PImage start;
Button startButton;
int r = height*6;
ArrayList <Food> food = new ArrayList<Food>();


void setup() {
  frameRate(120);
  fullScreen();
  music = new SoundFile(this, "nekodex - circles!.mp3");
  //beats = new BeatDetector(this);
  music.play();
  music.loop();
  //beats.sensitivity(1000);

  boolean play = false;
  background = loadImage("agarbg.png");
  imageMode(CENTER);
  start = loadImage("osulogo.png");
  startButton = new Button(width/2, height/2, r, r, 1.2, start);
}
void draw() {

  //Determine if user is in gameplay
  if (!play) {
    startScreen();
  } else {
    // Actual Playing Screen
    
    background(0);
    if(food.size() <= 2000){
      food.add(new Food(random(width), random(height)));
    }
    
    for(Food foodpart : food){
      foodpart.display();
    }
    text("test", width/2, height/2);
  }
}


void startScreen() {
  background(0);
  //parallax lol
  pushMatrix();
  translate(-mouseX*0.003, -mouseY*0.002);
  image(background, width/2, height/2, width*1.05, height*1.05);
  popMatrix();
  pushMatrix();
  translate(-mouseX*0.005, -mouseY*0.004);
  
  startButton.draw();

  popMatrix();
  /*if (beats.isBeat()==true) {
    play=true;
  }*/

  //Determine if the Button is being pressed
  boolean mouseClicked=startButton.mouseClicked();
  if (mouseClicked==true) {
    play=true;
  }
}
