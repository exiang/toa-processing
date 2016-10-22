import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*;

import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

Sprite wheel;
Sprite hand;
StopWatch sw = new StopWatch();


int xPos;
int speed;
int bgColor;

Minim minim;
AudioPlayer sou, playerC;

PImage background;
PImage img;

void setup()

{
    
size(640, 480);
background = loadImage("BG.png");
background.resize(640, 480);
xPos = 200;
speed = 3;


  
  img = loadImage("hand2.png");



minim = new Minim(this);
sou = minim.loadFile("bg.MP3");
playerC = minim.loadFile("ohyes.MP3");
sou.loop();

 wheel = new Sprite(this, "wheel.png", 5, 1, 99);
 wheel.setXY(326,387);
  wheel.setFrameSequence(0, 5, 0.05f);
  
  hand = new Sprite(this, "hand.png", 4 ,1, 99);
  hand.setXY(510,170);
  hand.setFrameSequence(0, 4, 0.09f);
  

}
void draw()
 {
   

   
  background(background);
  
  
  
  if (keyCode == 39){
     xPos = xPos+5;
   }
   else if (keyCode == 37){
     xPos = xPos-5;
   }
   
   if (xPos == 500) {
      xPos = -500; 
   }
   
   else if (xPos == -500) {
      xPos = 500; 
   }
  translate(xPos,0);
  myRobot(); 

 float elapsedTime = (float) sw.getElapsedTime();
  wheel.update(elapsedTime);
  wheel.draw();
  hand.update(elapsedTime);
  hand.draw();

}

void keyReleased() 
{
  if (key == 'c' || key =='C'){playC();}

}

void playC()
{
stopAll();
playerC.play(1);
}

void stopAll()
{
  if(playerC.isPlaying()){sou.pause(); playerC.rewind();}
  if(playerC.isPlaying()){sou.pause();sou.rewind();}
}

void myRobot()
{
 
  
  fill(133, 131, 106);
rect(217, 65, 216, 205);

fill(133, 131, 106);
rect(238, 270, 177, 31);

//screen




fill(255,203,7);
rect(250, 90, 154, 111);

// If the 'a' key is pressed draw a line
  if ((keyPressed == true) && (key == 'a')) {
 
 

fill(237, 31, 36);
rect(283,100, 23, 23);

fill(237, 31, 36);
rect(340,100, 23, 23);

fill(237, 31, 36);
rect(311,133, 23, 23);

fill(237, 31, 36);
rect(263,141, 23, 23);

fill(237, 31, 36);
rect(358,141, 23, 23);

fill(237, 31, 36);
rect(286,164, 23, 23);

fill(237, 31, 36);
rect(311,164, 23, 23);

fill(237, 31, 36);
rect(334,164, 23, 23);


  }


//Buttons
fill(198,158,82);
ellipse(265, 285, 20,20);

fill(198,158,82);
ellipse(305, 285, 20,20);

fill(198,158,82);
ellipse(343, 285, 20,20);

fill(198,158,82);
ellipse(382, 285, 20,20);

//leg
fill(0);
rect(317,300, 17,61);

image(img, 248, 270);


}
