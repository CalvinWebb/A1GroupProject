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
float[][] temps = {{0.5,0.5,0.5,0.5,0.5}};
Carnivore bestHerbivore=new Carnivore(width/2.0, height/2.0, temps, temps, 1.0, false);
Carnivore tester = new Carnivore(100, 100, temps, temps, 1.0, false);
Graph graph = new Graph();
Graph graph2 = new Graph();
Graph perfect = new Graph();

void setup() {
  fullScreen();
  SoundFile music = new SoundFile(this, "Among Us  Eurobeat Remix.mp3");
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
    for(Carnivore c: carnivore){
        c.updateINP();
      }
    tester.updateINP();
    tester.nn_dr = tester.input;
    tester.update_rotation();
    tester.update_pos();
    tester.display();
      for(int i = food.size() - 1; i >= 0; i--){
        if(tester.collide(food.get(i).locationx, food.get(i).locationy, food.get(i).r)){
          food.remove(food.get(i));
      }
    }


    graph.graph(#FF0000);
    graph2.graph(#00FF00);
    perfect.graph(#0000FF);
    perfect.add(0);
    for (int m=0; m<carnivore.size(); m++) {
      Carnivore carnivorepart = carnivore.get(m);
      carnivorepart.updateINP();
        carnivorepart.think();
        carnivorepart.update_rotation();
      carnivorepart.update_pos();
      carnivorepart.onEdge();
      carnivorepart.display();
      if (carnivorepart.canEatCell==false) {
        bestHerbivore=carnivorepart;
      }
      for (int i =0; i<food.size(); i++) {
        if (!carnivorepart.collide(food.get(i).locationx, food.get(i).locationy, food.get(i).r)) {
          food.get(i).display();
        } else {
          if(carnivorepart.canEatCell==true) {
          carnivorepart.r += 32748/(carnivorepart.r* carnivorepart.r);
          } else {
          carnivorepart.r += (32748/(carnivorepart.r* carnivorepart.r))*1.5;
          }
          if (food.size() > i) {
            food.remove(food.get(i));
            carnivorepart.fitness ++;
          }
        }
      }

      for (int j=0; j<carnivore.size(); j++) {
        // What is this? Edge detection? Carnivore Eat?
        if (carnivorepart.collide(carnivore.get(j).locationx, carnivore.get(j).locationy, carnivore.get(j).r) && carnivorepart.r/carnivore.get(j).r>=1.1&&carnivorepart.canEatCell==true) {
          carnivorepart.r+= 50000/(carnivorepart.r* carnivorepart.r);

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
  olist2.add(bestHerbivore);
  for (int amongus = olist.size() - 1; amongus >= 0; amongus--) {
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
  if (olist2.size()>0) {
    for (int i = 0; i < olist2.size(); i++) {
      for (int j = 1; j < olist2.size(); j++) {
        if (olist2.get(j-1).fitness < olist2.get(j).fitness) {
          temp = olist2.get(j-1);
          olist2.set(j-1, olist2.get(j));
          olist2.set(j, temp);
        }
      }
    }
  }
  graph.add(/*amplitude of graph*/5*(olist.get(0).nn_dr - olist.get(0).input));
  graph2.add(/*amplitude of graph*/5*(olist2.get(0).nn_dr - olist2.get(0).input));
  for (Carnivore carnivorepart : carnivore) {
    old_carnivore.add(carnivorepart);
  }

  olist.clear();
  olist2.clear();
  //for (int k = olist.size()-1; k > 0; k--) {
  //  olist.remove(k);
  //}
  // size is 4
  for (int l = 0; l < 10; l++) {
    olist.add(new Carnivore(width/2, height/2, old_carnivore.get(0).wih, old_carnivore.get(0).who, /*Neural Network learning*/0, true));
  }
  for (int claavin =0; claavin< 20; claavin++) {
    olist2.add(new Carnivore(width/2, height/2, old_carnivore.get(0).wih, old_carnivore.get(0).who, /*Neural Network learning*/0, false));
  }
  for (int asdf =olist2.size()-1; asdf>=0; asdf--) {
    olist.add(olist2.get(asdf));
  }
  int mat_pick = (int)random(0, 2.0);
  for (int d = 0; d< olist.size(); d++) {
    if (mat_pick == 1) {
      for (int p = 0; p< olist.get(d).wih.length; p++) {
        for (int h = 0; h< olist.get(d).wih[0].length; h++) {
          olist.get(d).wih[p][h] *= random(.9, 1.2);
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
          olist.get(d).who[u][y] *= random(.9, 1.2);
          if (olist.get(d).who[u][y] > 1) {
            olist.get(d).who[u][y] = 1.0;
          }
          if (olist.get(d).who[u][y] < -1) {
            olist.get(d).who[u][y] = -1.0;
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
  float rot = 0;
  for (int i = 0; i<food.size(); i++)
  {
    if (dist(food.get(i).locationx, food.get(i).locationy, carni.locationx, carni.locationy) < shortest)
    {
      shortest = dist(food.get(i).locationx, food.get(i).locationy, carni.locationx, carni.locationy);
      rot = degrees(atan2((food.get(i).locationy - carni.locationy), (food.get(i).locationx - carni.locationx))) - carni.rotation;
    }
  }
  if(abs(rot) > 180){
    rot += 360;
  }
  return rot/180;
}
