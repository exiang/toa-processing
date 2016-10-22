import ddf.minim.*;
Minim minim;
AudioPlayer player;
boolean play;
int button_x = 610, button_y = 195, button_sz = 10, button_sq = 15;

import sprites.utils.*;
import sprites.maths.*;
import sprites.*;
Sprite kkk, k;
StopWatch sw = new StopWatch();

float[] x = new float[50];
float[] y = new float[50];

int xPos, yPos = 0;
PImage bg;
//-------------------------Robot Arm ---------------------------//
int armAngle = 0;
/* Where upper left of robot appears on screen */
final int ROBOT_X = 0;
final int ROBOT_Y = 0;
/* The robot's midpoint and arm pivot points */
final int MIDPOINT_X = 0;
final int LEFT_PIVOT_X = 12;
final int RIGHT_PIVOT_X = 66;
final int PIVOT_Y = 32;

float leftArmAngle = 0.0;
float rightArmAngle = 0.0;
//-------------------------Robot Arm End------------------------//

Eye e1, e2;

void setup()
{
  frameRate(25);
  smooth();
  size(640, 420);
  bg = loadImage("bgbg.jpg");
  
  kkk = new Sprite(this, "kkk.png", 9, 1, 400);
  //('aplet','image', number of frame column, number of row, z-index)
  kkk.setXY(650, 320);
  kkk.setFrameSequence(0, 9, 0.5f);
                      //(start with which frame, total of frame, speed of frame per second)
  
  e1 = new Eye( 265,  210, 80);
  e2 = new Eye( 130, 210,  80);
  
  minim = new Minim(this);
  player = minim.loadFile("music.mp3");

for(int i = 0; i<x.length; i++) {
    x[i] = 0;
    y[i] = 0;
  }
}


 
void draw()
{
  background(35);
  image(bg,320,210);
  
  float mX;
  float mY;
  float elapsedTime = (float) sw.getElapsedTime();

  
  pushMatrix();
    scale(0.6);
    //translate(-200,-100);
    kkk.update(elapsedTime);
    kkk.draw();
  popMatrix();
  table();
  radio();
  door();
  pushMatrix();
  translate(ROBOT_X, ROBOT_Y); // place robot so arms are always on screen
  if (mousePressed)
  {
    mX = mouseX - ROBOT_X;
    mY = mouseY - ROBOT_Y;
    if (mX < MIDPOINT_X) // left side of robot
    {
      leftArmAngle = atan2(mY - PIVOT_Y, mX - LEFT_PIVOT_X)
      - HALF_PI;
    }
    else
    {
      rightArmAngle = atan2(mY - PIVOT_Y, mX - RIGHT_PIVOT_X)
      - HALF_PI;
   }
  }
  myRobot(xPos, yPos);
  smooth();
  popMatrix();
  
  for(int i = 0; i<x.length-1; i++) {
    // and shift all the values down one item
    x[i] = x[i+1];
    y[i] = y[i+1];
     
    // set the fill colour to be darker the
    // lower its index in the array
    fill(mouseX,mouseY,255,100);
    // and draw the circle at the position
    ellipse(x[i], y[i], 10,10);
     
  }
   
  // set the last items in the array to match the mouse position
  x[x.length-1] = mouseX;
  y[y.length-1] = mouseY;

}

void keyPressed() 
{
  if (key == CODED) 
  {
    if (keyCode == LEFT) 
    {
      xPos = xPos-10;
    } 
    else if (keyCode == RIGHT) 
    {
      xPos = xPos+10;
    } 
    else if (keyCode == UP) 
    {
      yPos = yPos-10;
    } 
    else if (keyCode == DOWN) 
    {
      yPos = yPos+10;
    } 
  }
}

void mousePressed(){
  if( mouseX > button_x && mouseX < button_x + button_sz &&
      mouseY > button_y && mouseY < button_y + button_sz){
  play = !play;//will switch false/true each click
      }
}
