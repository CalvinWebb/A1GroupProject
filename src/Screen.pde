import processing.sound.*;
import java.util.*;

SoundFile music;
PImage background;
boolean play;
PImage start;
Button startButton;
int r = height*6;
ArrayList <Food> food = new ArrayList<Food>();
ArrayList <Carnivore> carnivore = new ArrayList<Carnivore>();


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
    //Food
    if (food.size() <= 100) {
      food.add(new Food(random(width), random(height)));
    }



    //Carnivore
    if (carnivore.size() <=3) {
      carnivore.add(new Carnivore(width/2, height/2));
      carnivore.get(carnivore.size()-1).rotationAngle = random(0,2*PI);
    }

    for (Carnivore carnivorepart : carnivore) {
      carnivorepart.beforeEat = millis();
      carnivorepart.display();
      carnivorepart.move();
      for (int i =0; i<food.size(); i++) {
        if (carnivorepart.collide(food.get(i).locationx, food.get(i).locationy, food.get(i).r)) {
          if (carnivorepart.decision() == true){
            carnivorepart.rotationAngle = atan((food.get(i).locationx-carnivorepart.locationx)/(food.get(i).locationy-carnivorepart.locationy));
          }
          else {
            carnivorepart.rotationAngle = atan((food.get(i).locationx-carnivorepart.locationx)/(food.get(i).locationy-carnivorepart.locationy)) + PI;
          }
          food.remove(i);
          carnivorepart.r += 32748/(carnivorepart.r* carnivorepart.r);
        }
      }

    }
    for (Food foodpart : food) {
      for (Carnivore carnivorepart : carnivore) {
        if (foodpart.collide(carnivorepart.locationx, carnivorepart.locationy, r)==false) {
          foodpart.display();
          carnivorepart.Smartmess.add(millis()-carnivorepart.beforeEat);
        }
      }
    }
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
