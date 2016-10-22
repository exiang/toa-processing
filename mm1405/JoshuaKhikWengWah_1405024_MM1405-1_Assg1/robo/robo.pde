import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import sprites.utils.*;
import sprites.maths.*;
import sprites.*;
import g4p_controls.*;

Sprite jet;
GButton btnAdd;
StopWatch sw = new StopWatch();
int value = 0;
int exPose;
int spd;
int bg;
float jetPosX, jetPosY, jetSpeed;
ArrayList<Sprite> sprites = new ArrayList<Sprite>();
PImage background; 
PVector vback;

float x, y;
float angle1 = 0.0;
float angle2 = 0.0;
float segLength = 100;

AudioPlayer player;
Minim minim;

void setup()
{
  minim = new Minim (this);
  player = minim.loadFile("Transformers Classic Theme Orchestral.mp3", 2048);
  player.play();
  
  size (640, 480);
  background = loadImage("CyberD1500.jpg");
  vback = new PVector(0, 0);
  exPose = 0;
  spd = 5;
  
  x = 100;
  y = 100;

  jetPosX = 0;
  jetSpeed = 2;
  
  btnAdd = new GButton(this, 350, 0, 150, 50);
  btnAdd.setText("ADD Tetra Jet!");
  btnAdd.addEventHandler(this, "btnAddClick");
  
  jet = new Sprite (this, "sprite1.png", 1, 6, 99);
  jet.setXY(width/2-200,height);
  jet.setFrameSequence(0, 2, 0.03f);
  jet.setScale(0.5f);
  
  frameRate(25);

}

void draw()
{
background (255);
paraDraw(background, vback, 10);

  float elapsedTime = (float) sw.getElapsedTime();
  jetSpeed+=0.05;
  jetPosX = jetPosX + jetSpeed;
  if (jetPosX > width+100) 
    {
      jetPosX = -100;
      jetSpeed = 2;
    }
    
  for(int i=0; i<sprites.size(); i++)
  {
  Sprite jet = sprites.get(i);
  jet.setXY(jetPosX, jet.getY());
  jet.update(elapsedTime);
  jet.draw();
  }
    
  angle1 = (mouseX/float(width) - 0.5) * -PI;
  angle2 = (mouseY/float(height) - 0.5) * PI;
  //angle1 = radians(50*-1);
  //angle2 = radians(30*-1);
 
  myRobo();
}



void myRobo(){
  
    scale(0.6, 0.6);
    translate(width/2, 0);
    head();
    body();
    arms();
    legs();
}

void head(){
   //head
    pushMatrix();
    translate(mouseX/30-15, mouseY/100);
    stroke(0, 0, 255);
    fill(227, 227, 227);
    rect(200, 125, 40, 80);
    fill(227, 227, 227);
    rect(175, 100, 100, 80);
    fill(0, 256, 256);
    rect(190, 110, 25, 10);
    fill(0, 256, 256);
    rect(230, 110, 25, 10);
    fill(100, 100, 100);
    rect(185, 145, 80, 20);  
    popMatrix();
}

void body(){
    //body
    pushMatrix();
    translate(-mouseX/100, 0);
    fill(0, 0, 255);
    rect(150, 400, 150, 100);
    translate(mouseX/100, 0);
    fill(227, 227, 227);
    rect(175, 300, 100, 150);
    translate(-mouseX/100, 0);
    fill(255, 0, 0);
    rect(90, 200, 275, 150);
    
    fill(0, 256, 256);
    rect(150, 225, 150, 75);
    popMatrix();
}
void arms(){
    armleft();
    armright();
}
void armleft(){
    rectMode(CORNER);
    
    pushMatrix();
    
    //upper
    translate(50, 250);
    rotate(angle1);
    fill(227, 227, 227);
    rect(0, 0, 25, 100);
    
    //lower
    translate(10, 75);
    rotate(angle2);
    fill(0, 0, 255);
    rect(-25, -30, 50, 100);
    
    popMatrix();
    
    fill(255, 0, 0);
    rect(25, 200, 75, 75);
}

void armright(){
    rectMode(CORNER);
    
    pushMatrix();
    
    //upper
    translate(380, 250);
    rotate(-angle1);
    fill(227, 227, 227);
    rect(-25, -12, 25, 100);
    
    //lower
    translate(-25, 75);
    rotate(-angle2);
    fill(0, 0, 255);
    rect(-20, -12, 50, 100);
    
    popMatrix();
    
    fill(255, 0, 0);
    rect(350, 200, 75, 75);
}
void legs(){
    legleft();
    legright();
}
void legleft(){
   pushMatrix();  
  fill(227, 227, 227);
    rectMode(CORNER);
    rect(150, 470, 50, 150);
   
    fill(0, 0, 255);
    rect(125, 520, 75, 250);
    popMatrix();
}
void legright(){
   pushMatrix();  
  fill(227, 227, 227);
    rectMode(CORNER);
    
    rect(250, 470, 50, 150);
    fill(0, 0, 255);
    
    rect(250, 520, 75, 250);
    popMatrix();
}
void paraDraw(PImage img, PVector pos, float vel)
{
  imageMode(CORNER);
  pos.sub(vel, 0, 0);
  
  int r = (int)pos.x+img.width;

  if(r < width) image(img, r, pos.y);
  if(pos.x < width) image(img, pos.x-img.width, pos.y);  
  if(pos.x < -img.width) pos.x = width;
  
  image(img, pos.x, pos.y);
}

public void btnAddClick(GButton source, GEvent event) 
{
  Sprite tempjet = new Sprite (this, "sprite1.png", 1, 6, 99);
  tempjet.setXY(random(0, width), random(0, height));
  tempjet.setFrameSequence(0, 2, 0.03f);
  tempjet.setScale(0.5f);
  sprites.add(tempjet);
  println(sprites.size()); 
}

void stop()
{
  player.close();
  minim.stop();
  super.stop();
}
