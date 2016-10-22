PImage back, middle, front;
PVector vback, vmiddle, vfront;
int xPos,yPos = 0;
import sprites.utils.*;
import sprites.maths.*;
import sprites.*;
import ddf.minim.*;
int armAngle = 0;
/* Where upper left of robot appears on screen */
final int R2D2_X = 0;
final int R2D2_Y = 0;

/* The robot's midpoint and arm pivot points */
final int MIDPOINT_X = 39;
final int LEFT_PIVOT_X = 12;
final int RIGHT_PIVOT_X = 66;
final int PIVOT_Y = 30;

float leftArmAngle = 0.0;
float rightArmAngle = 0.0;

Minim minim;
AudioPlayer playerBg, playerS;


Sprite laser,xwing;
StopWatch sw = new StopWatch();
boolean isShooting = false;
 float elapsedTime ;

void setup()
{
  size(640,480);
  back = loadImage("deathstar.jpg");
  vback = new PVector(0, 0);
  
  laser = new Sprite(this, "laser.png", 3, 1, 99);
  laser.setXY(530, 170);//(start with which frame, total how many frame, speed of the frame)
  laser.setFrameSequence(0, 1, 0.1f);
  
  xwing = new Sprite(this, "xwing.png", 4, 1, 99);
  xwing.setXY(450, 100);
  xwing.setFrameSequence(0, 1, 0.3f);
  
  minim = new Minim(this);
  playerS = minim.loadFile("s.mp3");
  playerBg = minim.loadFile("b.mp3");
  playerBg.loop();
}

void paraDraw(PImage img, PVector pos, float vel)
{
  pos.sub(vel, 0, 0);
   
  int r = (int)pos.x + img.width;
 
  if(r < width) image(img, r, pos.y);
  if(pos.x < width) image(img, pos.x-img.width, pos.y); 
  if(pos.x < -img.width) pos.x = width;
  //println("r: " + r + ", pos.x: " +pos.x);
   
   imageMode(CORNER);
  image(img, pos.x, pos.y);
  //fill(#ff0000);
  //rect(pos.x, 0, img.width, img.height);
}

void draw(){
  float mX;
  float mY;
  
  pushMatrix();
  translate(R2D2_X, R2D2_Y); // place robot so arms are always on screen
  if (mousePressed)
  {
    mX = mouseX - R2D2_X;
    mY = mouseY - R2D2_Y;
    if (mX < MIDPOINT_X) // left side of robot
    {
      leftArmAngle = atan2(mY - PIVOT_Y, mX - LEFT_PIVOT_X)
      - HALF_PI;
    }
    else
    {
      rightArmAngle = atan2(mY - PIVOT_Y, mX - RIGHT_PIVOT_X)
      - HALF_PI;
   }}
  background(0);
  paraDraw(back, vback, 1);  
  R2D2(xPos, yPos); 
  xwing.update(elapsedTime);
  xwing.draw();
  popMatrix();
}



void R2D2(int x,int y){
  
  
  pushMatrix();
    rectMode(CORNER);
    translate(-100, 0);
    translate(x, y);
    
    //head
    fill(237,237,237);
    ellipse(315,180,150,150);
    
    //body
    fill(237,237,237);
    rect(240,195,150,200);
    
    //eye box
    fill(47,72,153);
    rect(300,150,30,20);
    
    //eye box2
    fill(47,72,153);
    rect(290,115,35,30);
    
    
    //right eye
    fill(228,30,30);
    ellipse(320,160,15,15);
    
    //neck
    fill(47,72,153);
    rect(240,180,150,16);
    
    //lines
    fill(47,72,153);
    rect(260,230,100,10);
    
    //lines2
    fill(47,72,153);
    rect(270,250,90,10);
    
    //lines3
    fill(47,72,153);
    rect(275,270,80,10);
    
//    //lines4
//    fill(237,237,237);
//    rect(220,200,30,200);
//    
//    //lines5
//    fill(237,237,237);
//    rect(380,200,30,200);
    
    drawLeftArm();
    drawRightArm();
    
//    //lines6
//    fill(47,72,153);
//    rect(225,197,10,140);
//    
//    //lines7
//    fill(47,72,153);
//    rect(395,197,10,140);
    
    
    
  
    elapsedTime = (float) sw.getElapsedTime();
    laser.update(elapsedTime);
    
    if(isShooting==true)
    {  
      laser.draw();
    }
 
  
  popMatrix();
}
void drawLeftArm()
{
  pushMatrix();
  translate(225, 197);
  //rotate(radians(135));
  //rotate(radians(armAngle));
    rotate(leftArmAngle);
   fill(237,237,237);
   rect(-20,0,30,200);
   fill(47,72,153);
   rect(0,0,10,140);
  
   popMatrix();
}
void drawRightArm()
{
  pushMatrix();
    rectMode(CORNER);
    translate(395, 198);
    //rotate(radians(135));
    //rotate(radians(-armAngle));
    rotate(rightArmAngle);
    fill(237,237,237);
    rect(0,0,30,200);
    fill(47,72,153);
    rect(0,0,10,140);
   
  popMatrix();
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

void keyReleased() {
  if (key == 's' || key == 'S') 
  {
    playS(); 
    isShooting = !isShooting;
  }
  else if (key == 'b' || key == 'B') {playB();}

  
  if(key=='-') mute();
  if(key=='=') unmute();
}

void mute()
{
  playerBg.mute();
}
void unmute()
{
  playerBg.unmute();
}

void playS()
{
  stopAll();
  playerS.play(1);
}
void playB()
{
  stopAll();
  playerBg.play(1);
}
void stopAll()
{
  if(playerS.isPlaying()){playerS.pause(); playerS.rewind();}
}
