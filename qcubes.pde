import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.effects.*;
import ddf.minim.signals.*;
import ddf.minim.spi.*;
import ddf.minim.ugens.*;

Minim minim;
AudioPlayer biisi;
ArrayList<Box> laatikot;

void setupAudio() {
  minim = new Minim(this);
  biisi = minim.loadFile("data/Ambler.mp3");
  biisi.setGain(-20); 
}

void setup(){
 //size(1280, 720, P3D);
 fullScreen(P3D);
 smooth();
 laatikot = laatikot();
 frameRate(60);
 setupAudio();
}

class Box{
   float x, y;
   int r, g, b;
   int xdir = 1;
   int ydir = -1;
   float xs = 3.0;
   float ys = 2.6;
   int koko = 40;
   int count = 0;
   
   Box(float xpos, float ypos){
     x = xpos;
     y = ypos;
     r = 0;
     g = 100;
     b = 100;
    }
  void update(float time){   
    x = x + (xs * xdir);
    y = y + (ys * ydir);
  
    if (x > width-koko || x < koko) {
      xdir *= -1;
      count++;
    }
    if (y > height-koko || y < koko) {
      ydir *= -1;
      count++;
    }
     fill(r, g, b);
     pushMatrix();
     translate(x, y);
     rotateY(radians(time*0.36));
     rotateX(radians(time*0.3));
     box(koko);
     popMatrix();
     
     switch(count){
       //punainen
       case 1:
         r = 200;
         g = 40;
         b = 35;
         break;
       //oranssi
       case 2:
         r = 190;
         g = 80;
         b = 40;
         break;
         //vihreä
       case 3:
         r = 100;
         g = 200;
         b = 100;
         break;
         //violetti
       case 4:
         r = 85;
         g = 45;
         b = 160;
         break;
         //turkoosi
       case 5:
         r = 0;
         g = 100;
         b = 100;
         break;
     }
     if(count > 5){
       count = 0; 
    }
  }
  
  void collidecheck(Box box, ArrayList<Box> lista){
   for(int i = 0; i < lista.size();i++){
     Box toinen = lista.get(i);
     if(dist(box.x, box.y, toinen.x, toinen.y) <= koko){
         box.xdir *= -1;
         box.ydir *= -1;
         lista.get(i).xdir *= -1;
         lista.get(i).ydir *= -1;
       }
    }
  }
  
}


ArrayList<Box> laatikot(){
  laatikot = new ArrayList<Box>();
  int xpos= width/8;
  int ypos = height/8;
  for(int i = 0; i < 24; i++){
    xpos += 50;
    ypos += 50;
    if(xpos >=width-40){
       xpos = width/8; 
    }
    if(ypos >=height-40){
       ypos = height/8; 
    }
    laatikot.add(new Box(xpos, ypos));
  }
  return laatikot;
}

void draw(){
  biisi.play();
  float time = (float)millis();  
  background(240,200,60);
  for(int i = 0; i < laatikot.size();i++){
    laatikot.get(i).update(time);
    laatikot.get(i).collidecheck(laatikot.get(i), laatikot);
  }
  if(time >= 48000){
    exit();
  }
}