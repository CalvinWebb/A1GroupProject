import processing.sound.*;
import java.util.*;

//timstep of .05
SoundFile music;
int carnivoreGeneration = 3;
PImage background;
boolean play;
boolean play2;
PImage start;
Button startButton;
int r = height*6;
public ArrayList <Food> food = new ArrayList<Food>();
public ArrayList <Carnivore> carnivore = new ArrayList<Carnivore>();
public ArrayList <Carnivore> old_carnivore = new ArrayList<Carnivore>();


void setup() {
  frameRate(120);
  fullScreen();
  SoundFile music = new SoundFile(this, "599182.mp3");
  //beats = new BeatDetector(this);
  music.play();
  music.loop();
  //beats.sensitivity(1000);

  boolean play = false;
  boolean play2 = false;
  background = loadImage("agarbg.png");
  imageMode(CENTER);
  start = loadImage("osulogo.png");
  startButton = new Button(width/2, height/2, r, r, 1.2, start);
  float[][]temp=new float[5][1];
  for (int ii=0; ii<5; ii++) {
    temp[ii][0]=0.5;
  }

  carnivore.add(new Carnivore(width/2, height/2, temp, temp, 1));
  carnivore.add(new Carnivore(width/2, height/2, temp, temp, 1));
  carnivore.add(new Carnivore(width/2, height/2, temp, temp, 1));
  carnivore.add(new Carnivore(width/2, height/2, temp, temp, 1));
}
void draw() {

  //Determine if user is in gameplay
  if (!play) {
    startScreen();
  } else {
    //food.add(new Food(width/2,height/2));
    
    // Actual Playing Screen
    if(play2) {
      play2=false;
      food.clear();
    evolveCarnivore(carnivore);
    carnivore.get(0).r=50;
    carnivore.get(0).locationx=width/2;
    carnivore.get(0).locationy=height/2;
    carnivore.get(0).fitness=0;
  }
    background(0);
    //Food
    if (food.size() <= 500) {
      food.add(new Food(random(width), random(height)));
    }
    


    //Carnivore
    //if (carnivore.size() <=carnivoreGeneration) {
    //  //carnivore.add(new Carnivore(width/2, height/2,));
    //}

    for (int m=0; m<carnivore.size(); m++) {
      Carnivore carnivorepart = carnivore.get(m);
      carnivorepart.beforeEat = millis();

      carnivorepart.think();
      carnivorepart.update_rotation();
      carnivorepart.update_pos();
      carnivorepart.display();

      for (int i =0; i<food.size()-1; i++) {
        if (carnivorepart.collide(food.get(i).locationx, food.get(i).locationy, food.get(i).r)) {
          carnivorepart.r += 32748/(carnivorepart.r* carnivorepart.r);
          carnivorepart.updateINP();
        }
      }
      for (int j=0; j*1.5<carnivore.size(); j++) {
        // What is this? Edge detection? Carnivore Eat?
        if (carnivorepart.collide(carnivore.get(j).locationx, carnivore.get(j).locationy, carnivore.get(j).r) && carnivorepart.r/carnivore.get(j).r>=1.1) {
          carnivorepart.r+=carnivore.get(j).r*0.5;
          carnivore.remove(j);
          carnivoreGeneration -= 1;
        }
      }
    }
    for (Food foodpart : food) {
      for (Carnivore carnivorepart : carnivore) {
        if (foodpart.collide(carnivorepart.locationx, carnivorepart.locationy, foodpart.r) == false) {
          foodpart.display();
        }
        else {
          food.remove(foodpart); 
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
  for (int i = 0; i<olist.size()-1; i++) {
    // We need to fix cell where fitness is incremented by 1 for every food it eats
    int key = olist.get(i).fitness;
    int j= i - 1;

    while (j>=0 && olist.get(i).fitness < key) {
      olist.get(i+1).fitness = olist.get(i).fitness;
      j = j - 1;
    }
    olist.get(i+1).fitness = key;
  }
  
  for(Carnivore carnivorepart: carnivore){
      old_carnivore.add(carnivorepart);
  }
  olist.clear();
  //for (int k = olist.size()-1; k > 0; k--) {
  //  olist.remove(k);
  //}
  // size is 4
  for (int l = 0; l < 4; l++) {
    olist.add(new Carnivore(old_carnivore.get(0).locationx, old_carnivore.get(0).locationy, old_carnivore.get(0).wih, old_carnivore.get(0).who, random(0, 360)));
  }
  int mat_pick = (int)random(0, 1.9);
  for (int d = 0; d< olist.size(); d++) {
    if (mat_pick == 1) {
      for (int p = 0; p< olist.get(d).wih.length; p++) {
        for (int h = 0; h< olist.get(d).wih[0].length; h++) {
          olist.get(d).wih[p][h] = random(.8, 1.2);
          if (olist.get(d).wih[p][h] > 1) {
            olist.get(d).wih[p][h] = 1;
          }
          if (olist.get(d).wih[p][h] < -1) {
            olist.get(d).wih[p][h] = -1;
          }
        }
      }
    } else {
      for (int u =0; u< olist.get(d).who.length; u++) {
        for (int y = 0; y< olist.get(d).who[0].length; y++) {
          olist.get(d).who[u][y] = random(.8, 1.2);
          if (olist.get(d).who[u][y] > 1) {
            olist.get(d).who[u][y] = 1;
          }
          if (olist.get(d).who[u][y] < -1) {
            olist.get(d).who[u][y] = -1;
          }
        }
      }
    }
  }
  old_carnivore.clear();
}

void mouseReleased() {
  play2=true;
}


public float distanceTo(Carnivore carni) 
{
  float shortest = dist(food.get(0).locationx, food.get(0).locationy, carni.locationx, carni.locationy);
  for(int i = 0; 1<food.size(); i++) 
  {
    if (dist(food.get(i).locationx, food.get(i).locationy, carni.locationx, carni.locationy) > shortest) 
    {
      shortest = dist(food.get(i).locationx, food.get(i).locationy, carni.locationx, carni.locationy);
      food.remove(i); //suspicious
      
    }
  }
  return shortest;
}
