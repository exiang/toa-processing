import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

int armAngle = 0;
int angleChange = 1;
final int ANGLE_LIMIT = 28;
//Sprite
    Sprite ballon;
    StopWatch sw = new StopWatch();
    
    Sprite ballonblue;
    StopWatch sw2 = new StopWatch();
    
    Sprite star;
    StopWatch sw3 = new StopWatch();
    
    Sprite star2;
    StopWatch sw4 = new StopWatch();
    
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
    float ground = 350;

PImage back, middle, front;
PVector vback, vmiddle, vfront;

import ddf.minim.*;

int a; 
float mx;
float my;
float easing = 1;
float esize = 27;
int box = 27;



Minim minim;
AudioPlayer playerBg;


void setup()

{
  
 size(640,480);
 noStroke(); 
 smooth();
 ellipseMode(CENTER);
 
  oldGuy = new SideJumper();
  oldGuy.position = new PVector(400, ground);
  oldGuy.direction = 1;
  oldGuy.velocity = new PVector(0, 0);
  oldGuy.jumpSpeed = 10;
  oldGuy.walkSpeed = 4;
 
 
  ballon = new Sprite(this, "ballon.png", 6, 1, 99);
  ballon.setXY(width/2, height/2);
  ballon.setFrameSequence(0, 6, 0.5f);
  
  ballonblue = new Sprite(this, "ballon-blue-01.png", 6, 1, 99);
  ballonblue.setXY(width/2, height/2);
  ballonblue.setFrameSequence(0, 6, 0.5f);
  
  star = new Sprite(this, "star-01.png", 6, 1, 99);
  star.setXY(width/2, height/2);
  star.setFrameSequence(0, 6, 0.5f);
  
  star2 = new Sprite(this, "star-02.png", 6, 1, 99);
  star2.setXY(width/2, height/2);
  star2.setFrameSequence(0, 6, 0.5f);
  
  
  minim = new Minim(this);
  playerBg = minim.loadFile("bg-music.mp3");
  playerBg.loop();

  
  
  size(640,480);
  back = loadImage("back.png");
  middle = loadImage("middle.png");
  front = loadImage("front.png");

  vback = new PVector(0, 0);
  vmiddle = new PVector(0, 0);
  vfront = new PVector(0, 0);
  
  frameRate(24);
}



void mute()
{
  playerBg.mute();
}

void unmute()
{
  playerBg.unmute();
}



void draw()
{
  
  background(255);
  
  paraDraw(back, vback, 5);
  paraDraw(middle, vmiddle, 10);
  paraDraw(front, vfront, 20);
 
  
  
  armAngle += angleChange;
  
  // if the arm has moved past its limit,
  // reverse direction and set within limits.
  if (armAngle > ANGLE_LIMIT || armAngle < 0)
  {
    angleChange = -angleChange;
    armAngle += angleChange;
  }
  
  
  float elapsedTime = (float) sw.getElapsedTime();
  
      updateOldGuy();
     // myrobot(0,0);
  
  ballon.update(elapsedTime);
  ballon.setXY(80, 210);
  ballon.draw();
  
  ballonblue.update(elapsedTime);
  ballonblue.setXY(570,220);
  ballonblue.draw();
  
  star.update(elapsedTime);
  star.setXY(150, 150);
  star.draw();
  
  star2.update(elapsedTime);
  star2.setXY(450, 90);
  star2.draw();
  
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
  
  // Always scale after translate and rotate.
  // We're using oldGuy.direction because a -1 scale flips the image in that direction.
  scale(oldGuy.direction, 1);
  
  //imageMode(CENTER);
  myrobot(0, 0);
  
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

void keyReleased()
{
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

void drawLeftArm()
{
  pushMatrix();
  translate(350, 130);
  rotate(radians(armAngle));
    fill(255,255,255);
    rect(0,0,30,5); // left arm
  popMatrix();
}

void drawRightArm()
{
  pushMatrix();
  translate(310, 130);
  rotate(radians(-armAngle));
    fill(255,255,255);
    rect(0,0,-30,5); // right arm
  popMatrix();
}


void myrobot(int x, int y)
{
  
  pushMatrix();
    //translate(x-600, y-75);
    //scale(2);
    
    scale(2);
    translate(x-330, y-150);
    
    
   //head
    noStroke();
    fill(249, 133, 214);
    ellipse(330,90,60,60);
    
    //ear
    fill(249, 133, 214);
    ellipse(350,60,7,40);
    ellipse(310,60,7,40);
    
    //neck
    ellipse(330,110,10,30);
    
    //whte eye
    fill(255,255,255);
    ellipse(330,90,40,40);
    
    //black eye
    //fill(0,0,0);
    //ellipse(330,90,20,20);
    
    
  drawLeftArm();
  drawRightArm();
    
    //body
    fill(249, 133, 214);
    rect(304,123,50,50);
    
    //leg
    fill(255, 255, 255);
    rect(310,173,5,30);
    rect(342,173,5,30);
    
    
    //hand-left
   
    
    //right-hand
    
    
  if(abs(mouseX - mx) > 0.1) 
  {
   mx = mx + (mouseX - mx) * easing;
  }
 
  if(abs(mouseY - my) > 0.1) 
  {
   my = my + (mouseY- my) * easing;
  }
  
  
   float distance = esize * 2;
   mx = constrain(mx, 330, 335);  //x co-ordinates for eye (min, max)
   my = constrain(my, 90, 95);  //y co-ordinate for eye (min, max)
   fill(0);  
   ellipse(mx, my, esize, esize);

    popMatrix();
}



