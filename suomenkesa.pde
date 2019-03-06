import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;
Minim minim;
AudioPlayer song;
PImage kukka;
PImage greets;
PImage kesa;
PImage syksy;
PImage meri;
PImage pilvi1;
PImage pilvi2;
PImage kyltti;
ArrayList<Sade> vetta;
ArrayList<Lumi> lunta;
//int width = 1920/2;
//int height = 1080/2;
int width = 1440;
int height = 810;
void setup(){
  size(width, height, P3D);
  
  frameRate(60);
  kukka = loadImage("flowersun.png");
  greets = loadImage("the_end.png");
  kesa = loadImage("rain_bg.png");
  syksy = loadImage("snow_bg.png");
  meri = loadImage("meri_bg.png");
  pilvi1 = loadImage("cloud_nr1.png");
  pilvi2 = loadImage("cloud_nr2.png");
  kyltti = loadImage("kyltti.png");
  kesa.resize(width, height);
  syksy.resize(width, height);
  meri.resize(width, height);
  pilvi1.resize(0, 90);
  pilvi2.resize(0, 90);
  greets.resize(width, height);
  imageMode(CENTER);
  vetta = sataa();
  lunta = lunta();
  setupAudio();
}

void setupAudio() {
  minim = new Minim(this);
  song = minim.loadFile("suomenkesa.wav");
}

void aalto_vaaka(float time){
  for(int i = 1; i < 8; i++){
    float posY = (32 + i) * sin(time + 0.5 * (float)i) + height/8;
    float posX = width - (width/8) * i - time * 2.0;
    if(i%2 == 0){
    image(pilvi2, posX, posY);
    }
    else{
      image(pilvi1, posX, posY);
    }
  }
}

class Sade {
  float koko, xpos, ypos, time, speed;
  Sade(){
    xpos = random(-500, width);
    ypos = random(-500, 0);
    koko = random(3,11);
    if(koko >=3 && koko <=5){
      speed = 4.0;
    }
    if(koko >=6 && koko <=8){
      speed = 4.5;
    }
    if(koko >=9 && koko <=10){
      speed = 5.0;
    }
  }
  void update(){
    ypos += speed;
    xpos += 1.0;
    noStroke();
    fill(0,120,200);
    ellipse(xpos, ypos, koko, koko);
    if(koko <=5 && ypos > (height - height/2.5)){
      xpos = random(-500, width);
      ypos = random(-500, 0);
      koko = random(3,11);
    }
    if(koko >=6 && koko <=8 && ypos > (height - height/4)){
      xpos = random(-500, width);
      ypos = random(-500, 0);
      koko = random(3,11);
    }
    if(ypos > height){
      xpos = random(-500, width);
      ypos = random(-500, 0);
      koko = random(3,11);
    }
  }
}

class Lumi{
  float koko, xpos, ypos, time, speed;
  Lumi(){
    xpos = random(-100, width + 200);
    ypos = random(-200, 0);
    koko = random(8,21);
    if(koko >=8 && koko <=12){
      speed = 0.5;
    }
    if(koko >=13 && koko <=16){
      speed = 1.0;
    }
    if(koko >=17 && koko <=20){
      speed = 1.5;
    }
  }
  void update(float time){
    ypos += 1.0 + speed;
    xpos += 2 * sin(time/2*PI);
    noStroke();
    fill(255,255,255, 127);
    ellipse(xpos, ypos, koko, koko);
    if(koko <=12 && ypos > (height - height/3)){
      xpos = random(-100, width + 200);
      ypos = random(-200, 0);
      koko = random(8,20);
    }
    if(koko >=13 && koko <=15 && ypos > (height - height/4)){
      xpos = random(-100, width + 200);
      ypos = random(-200, 0);
      koko = random(8,20);
    }
    if(ypos > height){
      xpos = random(-100, width + 200);
      ypos = random(-200, 0);
      koko = random(8,20);
    }
  }
}

ArrayList<Sade> sataa(){
  ArrayList<Sade> sade = new ArrayList<Sade>();
  for(int a=0;a<4000;a++){
    sade.add(new Sade());  
  }
  return sade;
}

ArrayList<Lumi> lunta(){
  ArrayList<Lumi> lumi = new ArrayList<Lumi>();
  for(int a=0;a<2000;a++){
    lumi.add(new Lumi());  
  }
  return lumi;
}

void fadeOut(float time, float aika){
  float kert = ((time - aika)/3.0);
  fill(0, kert * 240 );
  rect(0,0,width,height);
}

void fadeIn(float time, float kohta){
  float kert2 = ((time - kohta)/3.0);
     fill(0, (1.0-kert2) * 255);
     rect(0,0,width,height);
}
boolean sketchFullScreen(){
    return true;
}

void kuvarotaatio(float time){
  pushMatrix();
  translate(width - width/6, height - 250);
  float rota = PI/-6.0*time;
  rotateY(rota);
  image(kyltti, 0, 0);
  popMatrix();
  
}
void pyoriva(float time){
  pushMatrix();
  float koko = 40.0;
  float angle = -PI/2 * time;
  noStroke();
  translate((width - width/14), height/10);
  rotate(angle);
  scale(0.15);
  image(kukka,0,0);
  popMatrix();
}
void draw(){
  float time = (float)millis()/1000;
  if(time > 4){
      song.play();
  }
  
  if(time <= 20){
     background(kesa);
     for(int i=0;i<vetta.size();i++){
       vetta.get(i).update();
     }
   }
   
   if(time >16){
     fadeOut(time, 17.0);
   }
   
   if(time > 19){
     background(syksy);
     fadeIn(time, 20.0);
   }
   
   if(time > 22){
     background(syksy);       
     for(int i=0;i<lunta.size();i++){
       lunta.get(i).update(time);
     }
   }
   
   if(time > 39){
     fadeOut(time, 40.0);
   }
   
   if(time > 42){
     background(meri);
     fadeIn(time, 43.0);
   }
   
   if(time > 44){
     background(meri);
     aalto_vaaka(time);
     pyoriva(time);
   }
   
   if(time > 62){
     fadeOut(time, 63.0);
   }
   
   if(time > 65){
     background(greets);
     fadeIn(time, 66.0);
   }
   if(time > 67){
     background(greets);
     rectMode(CENTER);
     kuvarotaatio(time);
   }
   
   if(time > 84){
     rectMode(CORNER);
     fadeOut(time, 85.0);
   }
   if(time > 87){
     exit();
   }
}
