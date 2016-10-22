 import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

int armAngle = 0;
int angleChange = 1;
final int ANGLE_LIMIT = 28;

import ddf.minim.*;

Minim minim;
AudioPlayer playerBg;

StopWatch sw = new StopWatch();
Sprite coin;

class SideJumper
{
  PVector position;
  float direction;
  PVector velocity;
  float jumpSpeed;
  float walkSpeed;
}

// GLOBAL VARIABLES

SideJumper oldGuy;
float left;
float right;
float up;
float down;

// half a pixel per frame gravity.
float gravity = .5;

// Y coordinate of ground for collision
float ground = 300;

PImage back, middle, front;
PVector vback, vmiddle, vfront;


int speed;
int speedMin;
int bgColor;
int moveIt;

void setup ()
{
  size(640, 480);
  speed = 2;
  speedMin = -2;
  bgColor = 0;
  int moveIt = 2;
  
  back = loadImage("back.png");
  middle = loadImage("middle.png");
  front = loadImage("front.png");

  vback = new PVector(0, 0);
  vmiddle = new PVector(0, 0);
  vfront = new PVector(0, 0);
  
  oldGuy = new SideJumper();
  oldGuy.position = new PVector(400, ground);
  oldGuy.direction = 1;
  oldGuy.velocity = new PVector(0, 0);
  oldGuy.jumpSpeed = 10;
  oldGuy.walkSpeed = 4;
  
  frameRate(24);
  
  
  minim = new Minim(this);
  playerBg = minim.loadFile("bg.mp3");
  playerBg.loop();
  
  coin = new Sprite(this, "coin.png", 10, 1, 99);
  coin.setXY(width/2, height/2);
  coin.setFrameSequence(0, 10, 0.1f);
  
}

void draw (){
  
  
  background(255);
  
  
  paraDraw(back, vback, 5);
  paraDraw(middle, vmiddle, 10);
  paraDraw(front, vfront, 20);
  
  
  float elapsedTime = (float) sw.getElapsedTime();
  
  
  //drawSpongebot(0, 0);
  updateOldGuy();
  
   armAngle += angleChange;
  
  // if the arm has moved past its limit,
  // reverse direction and set within limits.
  if (armAngle > ANGLE_LIMIT || armAngle < 0)
  {
    angleChange = -angleChange;
    armAngle += angleChange;
  }
  
  
  coin.update(elapsedTime);
  coin.draw();
  
}

void updateOldGuy()
{
  // Only apply gravity if above ground (since y positive is down we use < ground)
  if (oldGuy.position.y < ground)
  {
    oldGuy.velocity.y += gravity;
  }
  else
  {
    oldGuy.velocity.y = 0; 
  }
  
  // If on the ground and "jump" keyy is pressed set my upward velocity to the jump speed!
  if (oldGuy.position.y >= ground && up != 0)
  {
    oldGuy.velocity.y = -oldGuy.jumpSpeed;
  }
  
  // Wlak left and right. See Car example for more detail.
  oldGuy.velocity.x = oldGuy.walkSpeed * (left + right);
  
  // We check the nextPosition before actually setting the position so we can
  // not move the oldguy if he's colliding.
  PVector nextPosition = new PVector(oldGuy.position.x, oldGuy.position.y);
  nextPosition.add(oldGuy.velocity);
  
  // Check collision with edge of screen and don't move if at the edge
  float offset = 0;
  if (nextPosition.x > offset && nextPosition.x < (width - offset))
  {
    oldGuy.position.x = nextPosition.x;
  } 
  if (nextPosition.y > offset && nextPosition.y < (height - offset))
  {
    oldGuy.position.y = nextPosition.y;
  } 
  
  // See car example for more detail here.
  pushMatrix();
  
    translate(oldGuy.position.x, oldGuy.position.y);
    
    //println(oldGuy.position.x + " " + oldGuy.position.y);
    // Always scale after translate and rotate.
    // We're using oldGuy.direction because a -1 scale flips the image in that direction.
    scale(oldGuy.direction, 1);
    
    //imageMode(CENTER);
    drawSpongebot(0, 0);
  popMatrix();
}

void keyPressed()
{
  if (key == 'd')
  {
    right = 1;
    oldGuy.direction = -1;
  }
  if (key == 'a')
  {
    left = -1;
    oldGuy.direction = 1;
  }
  if (key == ' ')
  {
    up = -1;
  }
  if (key == 's')
  {
    down = 1;
  }
}

 

  
  //keyboard

      


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



void keyReleased() {
     
      if(key== '-') mute();
      if(key== '=') unmute();
      
       if (key == 'd')
  {
    right = 0;
  }
  if (key == 'a')
  {
    left = 0;
  }
  if (key == ' ')
  {
    up = 0;
  }
  if (key == 's')
  {
    down = 0;
  }
}
    
    void mute()
    {
      playerBg.mute();
    }
    
    void unmute()
    {
      playerBg.unmute();
    }
    
void drawLeftArm()
{
  pushMatrix();
  translate(40, 170);
  rotate(radians(armAngle));
    fill(255, 244, 110);
    rect(0,0,50,10); // left arm
  popMatrix();
}

void drawRightArm()
{
  pushMatrix();
  translate(205, 170);
  rotate(radians(-armAngle));
    fill(255, 244, 110);
    rect(0,0,-50,10); // right arm
  popMatrix();
}



void drawSpongebot(int x, int y)
{
  pushMatrix();
    translate(x-120, y-130);
    
    noStroke();
    rectMode(CENTER);
    
    //body
    fill(255, 244, 110);
    rect(122, 138, 124, 162);
    
    //spongeholes
    fill(191, 214, 95);
    ellipse(77, 71, 8, 8);
    ellipse(70, 83, 4, 4);
    ellipse(156, 68, 5, 5);
    
    //eyes
    
    //eye left
    fill(255, 255, 255);
    ellipse(101, 110, 40, 40);
    
    fill(59, 167, 255);
    ellipse(101, 116, 15, 15);
    
    fill(0, 0, 0);
    ellipse(101, 116, 9, 9);
    
    //eye right
    fill(255, 255, 255);
    ellipse(143, 110, 40, 40);
    
    fill(59, 167, 255);
    ellipse(143, 116, 15, 15);
    
    fill(0, 0, 0);
    ellipse(143, 116, 9, 9);
    
    //arm
    drawLeftArm();
    drawRightArm();
    
    //Mouth
    fill (144, 37, 37);
    rect(122, 153, 70, 20);
    
    //teeth
    fill (255, 255, 255);
    rect (116, 147, 10, 11);
    rect (128, 147, 10, 11);
    
    //shirt
    rect (122, 197, 124, 14);
    
    //pants
    fill (142, 83, 43);
    rect (122, 214, 124, 20);
    
    rect (102, 228, 23, 9);
    rect (142, 228, 23, 9);
    
    //legs
    fill(255, 244, 110);
    rect (102, 254, 8, 42);
    rect (144, 254, 8, 42);
    
    //socks
    fill(230, 255, 255);
    rect (102, 267, 8, 15);
    rect (144, 267, 8, 15);
    
    //shoes
    fill(0,0,0);
    rect (93, 281, 38, 12);
    rect (152, 281, 38, 12);
     
    //tie
    fill(255, 77, 77);
    triangle(113, 190, 122, 197, 133, 190);
    triangle(112, 208, 122, 197, 132, 208);
    triangle(112, 208, 122, 219, 132, 208);

  popMatrix();
}


