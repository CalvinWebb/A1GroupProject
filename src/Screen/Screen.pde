import processing.sound.*;
import java.util.*;

//timstep of .05
SoundFile music;
int carnivoreGeneration = 3;
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
    if (carnivore.size() <=carnivoreGeneration) {
      carnivore.add(new Carnivore(width/2, height/2));
    }

    for (int m=0; m<carnivore.size(); m++) {
      Carnivore carnivorepart = carnivore.get(m);
      carnivorepart.beforeEat = millis();
      carnivorepart.display();
      carnivorepart.update_pos();
      for (int i =0; i<food.size(); i++) {
        if (carnivorepart.collide(food.get(i).locationx, food.get(i).locationy, food.get(i).r)) {
          food.remove(i);
          carnivorepart.r += 32748/(carnivorepart.r* carnivorepart.r);
        }
      }
      for (int j=0; j*1.5<carnivore.size(); j++) {
        if (carnivorepart.collide(carnivore.get(j).locationx, carnivore.get(j).locationy, carnivore.get(j).r) && carnivorepart.r/carnivore.get(j).r>=1.1) {
          carnivorepart.r+=carnivore.get(j).r*0.5;
          carnivore.remove(j);
          carnivoreGeneration -= 1;
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

void evolveCarnivore(ArrayList<Carnivore> olist) {
  for (int i = 1; i<olist.size(); i++) {
    // We need to fix cell where fitness is incremented by 1 for every food it eats
    int key = olist.get(i).fitness;
    int j= i - 1;

    while (j>=0 && olist.get(i).fitness < key) {
      olist.get(i+1).fitness = olist.get(i).fitness;
      j = j - 1;
    }
    olist.get(i+1).fitness = key;
  }
  for (int k = olist.size(); k > 1; k--) {
    olist.remove(k);
  }
  // size is 4

  int mat_pick = (int)random(0, 1.1);
  if (mat_pick == 1) {
    for (int i =0; i< olist.get(0).wih.length; i++) {
      for (int j = 0; j< olist.get(0).wih[0].length; i++) {
        olist.get(0).wih[i][j] = random(.8,1.2);
        if(olist.get(0).wih[i][j] > 1){
        olist.get(0).wih[i][j] = 1;
        }
        if(olist.get(0).wih[i][j] < -1){
        olist.get(0).wih[i][j] = -1;
        }
      }
    }
  }else{
  for (int i =0; i< olist.get(0).who.length; i++) {
      for (int j = 0; j< olist.get(0).who[0].length; i++) {
        olist.get(0).who[i][j] = random(.8,1.2);
        if(olist.get(0).who[i][j] > 1){
        olist.get(0).who[i][j] = 1;
        }
        if(olist.get(0).who[i][j] < -1){
        olist.get(0).who[i][j] = -1;
        }
      }
    }
  }
  for (int l = 0; l < 4; l++) {
    olist.add(new Carnivore(olist.get(0).locationx,olist.get(0).locationy, olist.get(0).wih, olist.get(0).who, /* supposed to be nearest food*/ 30));
  }
}
