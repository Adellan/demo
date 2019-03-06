import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

import moonlander.library.*;
Moonlander moon;
PImage keiju;
PImage kuvio;;

void setup(){
  fullScreen();
  frameRate(60);
  keiju = loadImage("data/krapulakeiju.png");
  keiju.resize(width, height);
  kuvio = loadImage("data/kuvio.png");
  imageMode(CENTER);
  moon = Moonlander.initWithSoundtrack(this, "data/MoveForward.mp3", 111, 8);
  moon.start("localhost", 1339, "data/synkki");
}

void taustakaruselli(float time, float val){
  //pyörii paikallaan keskellä ruutua
  float suunta = 0.0;
  if(val != 4.00){
    switch(floor(val)){
      case 6:
       suunta = 1.0;
       break;
       default:
       suunta = -1.0;
       break;
    }
    pushMatrix();
    float angle = suunta * time;
    translate(width/2, height/2);
    rotate(angle);
    scale(1.8);
    image(kuvio,0,0);
    popMatrix();
  }
}

void bcolsync(float val){
  int num = floor(val);
  switch(num){
    //kulta
    case 1:
    background(235,240,30);
    break;
    //terrakotta
    case 2:
    background(250,130,40);
    break;
    //tummapunaruskea
    case 3:
    background(210,60,45);
    break;
    //mörkö
    case 4:
    background(keiju);
    break;
    //turkoosi
    case 5:
    background(80,225,115);
    break;
    //oranssi
    default:
    background(250,200,80);
    break;
  }
}

void liike(float time){
  pushMatrix();
  translate(width/2, height/2);
  noStroke();
  fill(50, 180,245);
  for(int i = 0; i < 1000; i+=5){
    float r = radians(i*time/2);
    float x = r * cos(r);
    float y = r * sin(r);
    ellipse(x,y,8,8);
  }
  popMatrix();
}

void draw(){
  moon.update();
  float time = (float)millis()/1000;
  background(250,200,80);
  float val = (float)moon.getValue("val");
  bcolsync(val);
  taustakaruselli(time, val);
  liike(time);
  if(val == 13.0){
    exit();
  }
}