import ddf.minim.spi.*;
import ddf.minim.signals.*;
import ddf.minim.*;
import ddf.minim.analysis.*;
import ddf.minim.ugens.*;
import ddf.minim.effects.*; 

int xPos;
int speed;
int armAngle = 0;
int angleChange = 2;
final int ANGLE_LIMIT = 10; 
import sprites.utils.*;
import sprites.maths.*;
import sprites.*;
Sprite body, bgmusic;
StopWatch sw = new StopWatch();

PImage background;

Minim minim;
AudioPlayer sou;
void setup()
{
size(640, 480);
background = loadImage("img.jpg");
background.resize(640, 480);
noStroke();
xPos = 0;
  body = new Sprite(this, "body.png", 6, 1, 99);
  body.setXY(325, 254);
  body.setFrameSequence(0, 6, 0.2f);
  
  bgmusic = new Sprite(this, "bgmusic.png", 8, 1, 99);
  bgmusic.setXY(324, 234);
  bgmusic.setFrameSequence(0, 8, 0.25f);
  
  minim = new Minim(this);
  sou = minim.loadFile("bg.mp3");
  sou.loop();
}

void draw() 
{
  float elapsedTime = (float) sw.getElapsedTime();
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
  background(background);
  
  bgmusic.update(elapsedTime);
  bgmusic.draw();
//  translate(xPos,0);
  //drawRobot(); 
  //background(background);
 
  pushMatrix();
    translate(xPos, 72); // place robot so arms are always on screen
    drawRobot();
    armAngle += angleChange;
    
    // if the arm has moved past its limit,
    // reverse direction and set within limits.
    if (armAngle > ANGLE_LIMIT || armAngle < 0)
    {
      angleChange = -angleChange;
      armAngle += angleChange;
    }
    body.update(elapsedTime);
    body.draw();
    popMatrix();
 
  

  
}

void drawRobot()
{
fill(11,162,186);
rect(250, 85, 150, 80, 10);
fill(188,229,241);
rect(262, 95, 126, 60, 10);
fill(11,162,186);
ellipse(295, 125, 35, 35);
fill(208,32,39);
ellipse(295, 125, 10, 10);
fill(11,162,186);
ellipse(355, 125, 35, 35);

  // If the 'a' key is pressed draw a line
  if ((keyPressed == true) && (key == 'a')) {
  fill (255,255,255);
  rect(346, 123, 18, 4, 6);

  /* fill(208,32,39);
  ellipse(355, 125, 18, 18);
  */ //redeye
  } else { // Otherwise, draw an ellipse
    fill(0,0,0);
    ellipse(355, 125, 20, 20);
  }
  drawLeftArm();
  drawRightArm();
 

fill(188,229,241);
rect(302, 165, 45, 15);
fill(11,162,186);
rect(275, 180, 100, 120, 10);
fill(188,229,241);
ellipse(339, 198, 10, 10);
fill(188,229,241);
ellipse(355, 198, 10, 10);


fill(188,229,241);
rect(290, 300, 20, 75);
fill(11,162,186);
ellipse(300, 390, 35, 35);
fill(188,229,241);
rect(340, 300, 20, 75);
fill(11,162,186);
ellipse(350, 390, 35, 35);
}

void drawLeftArm()
{
  pushMatrix();
  translate(120, 132);
  rotate(radians(-armAngle));
  fill(188,229,241);
  rect(65, 85, 90, 20); 
  fill(11,162,186);
  rect(60, 82, 30, 30, 7);
  popMatrix();
}

void drawRightArm()
{
  pushMatrix();
  translate(120, 132);
  rotate(radians(armAngle));
  fill(188,229,241);
  rect(250, 50, 90, 20); 
  fill(11,162,186);
  rect(320, 45, 30, 30, 7);
  popMatrix();
}



