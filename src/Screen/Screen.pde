import processing.sound.*;
import java.util.*;

//timstep of .05
SoundFile music;
PImage background;
boolean play;
boolean play2;
PImage start;
Button startButton;
int r = height*6;
public ArrayList <Food> food = new ArrayList<Food>();
public ArrayList <Carnivore> carnivore = new ArrayList<Carnivore>();
public ArrayList <Carnivore> old_carnivore = new ArrayList<Carnivore>();
Graph graph = new Graph();

Graph graph2 = new Graph();

void setup() {
  frameRate(120);
  fullScreen();
  SoundFile music = new SoundFile(this, "599182.mp3");
  music.play();
  music.loop();

  boolean play = false;
  boolean play2 = false;
  background = loadImage("torekka.png");
  imageMode(CENTER);
  start = loadImage("osulogo.png");
  startButton = new Button(width/2, height/2, r, r, 1.2, start);
  float[][]temp=new float[5][1];
  for (int ii=0; ii<5; ii++) {
    temp[ii][0]=0.5;
  }

  for (int i = 0; i < /*number of carnivores*/ 10; i++ ) {
    carnivore.add(new Carnivore(width/2, height/2, temp, temp, 1, true));
  }
  for (int i = 0; i < /*number of herbivores*/ 20; i++ ) {
    carnivore.add(new Carnivore(width/2, height/2, temp, temp, 1, false));
  }
}
void draw() {
  //Determine if user is in gameplay
  if (!play) {
    startScreen();
  } else {

    // Actual Playing Screen
    if (play2) {
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
    if (food.size() <= 10) {
      food.add(new Food(random(width), random(height)));
    }



    graph.graph(#FF0000);
    for (int m=0; m<carnivore.size(); m++) {
      Carnivore carnivorepart = carnivore.get(m);
      carnivorepart.beforeEat = millis();
      carnivorepart.update_pos();
      carnivorepart.onEdge();
      carnivorepart.display();

      for (int i =0; i<food.size(); i++) {
        if (!carnivorepart.collide(food.get(i).locationx, food.get(i).locationy, food.get(i).r)) {
          food.get(i).display();
        } else {
          System.out.println(i);
          System.out.println("Collision");
          carnivorepart.r += 32748/(carnivorepart.r* carnivorepart.r);
          carnivorepart.updateINP();
          System.out.println("cock" + carnivorepart.input);
          carnivorepart.think();
          carnivorepart.update_rotation();
          if (food.size() > i) {
            food.remove(food.get(i));
          }
        }
      }

      for (int j=0; j<carnivore.size(); j++) {
        // What is this? Edge detection? Carnivore Eat?
        if (carnivorepart.collide(carnivore.get(j).locationx, carnivore.get(j).locationy, carnivore.get(j).r) && carnivorepart.r/carnivore.get(j).r>=1.1&&carnivorepart.canEatCell==true) {
          carnivorepart.r+=carnivore.get(j).r*0.5;
          carnivore.remove(j);
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
  Carnivore temp;
  ArrayList<Carnivore> olist2 = new ArrayList<Carnivore>();
  for (int amongus = olist.size() - 1 ; amongus >= 0; amongus--) {
    if (olist.get(amongus).canEatCell==false) {
      olist2.add(olist.get(amongus));
      olist.remove(amongus);
    }
  }
  for (int i = 0; i < olist.size(); i++) {
    for (int j = 1; j < olist.size(); j++) {
      if (olist.get(j-1).fitness < olist.get(j).fitness) {
        temp = olist.get(j-1);
        olist.set(j-1, olist.get(j));
        olist.set(j, temp);
      }
    }
  }
  for (int i = 0; i < olist2.size(); i++) {
    for (int j = 1; j < olist2.size(); j++) {
      if (olist2.get(j-1).fitness < olist2.get(j).fitness) {
        temp = olist2.get(j-1);
        olist2.set(j-1, olist2.get(j));
        olist2.set(j, temp);
      }
    }
  }
  System.out.println(olist2.size());
  graph.add(olist.get(0).nn_dr/olist.get(0).input);
  //graph2.add(olist2.get(0).nn_dr/olist2.get(0).input);
  for (Carnivore carnivorepart : carnivore) {
    old_carnivore.add(carnivorepart);
  }
  
  olist.clear();
  olist2.clear();
  //for (int k = olist.size()-1; k > 0; k--) {
  //  olist.remove(k);
  //}
  // size is 4
  for (int l = 0; l < old_carnivore.size(); l++) {
    olist.add(new Carnivore(old_carnivore.get(0).locationx, old_carnivore.get(0).locationy, old_carnivore.get(0).wih, old_carnivore.get(0).who, /*Neural Network learning*/random(0, 360), true));
  }
  for (int claavin =0; claavin< old_carnivore.size();claavin++) {
    olist2.add(new Carnivore(old_carnivore.get(0).locationx, old_carnivore.get(0).locationy, old_carnivore.get(0).wih, old_carnivore.get(0).who, /*Neural Network learning*/random(0, 360), false));
  }
  int mat_pick = (int)random(0, 1.9);
  for (int d = 0; d< olist.size(); d++) {
    if (mat_pick == 1) {
      for (int p = 0; p< olist.get(d).wih.length; p++) {
        for (int h = 0; h< olist.get(d).wih[0].length; h++) {
          olist.get(d).wih[p][h] *= random(.8, 1.2);
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
          olist.get(d).who[u][y] *= random(.8, 1.2);
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
  double rot = 0;
  for (int i = 0; i<food.size(); i++)
  {
    if (dist(food.get(i).locationx, food.get(i).locationy, carni.locationx, carni.locationy) < shortest)
    {
      System.out.print("Joe biden");
      shortest = dist(food.get(i).locationx, food.get(i).locationy, carni.locationx, carni.locationy);
      rot = Math.atan((food.get(i).locationy - carni.locationy)/(food.get(i).locationx - carni.locationx));
    }
  }
  return (float)rot*180/PI;
}
