import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

import ddf.minim.*;

Minim minim;
AudioPlayer playerN, playerBg;

int speed;
int bgColor;
int xPos, yPos = 0;
PImage bg, nRobot;
int y;
int dayMode;
int myRobot;
boolean eyeSide= false, mouthA= false;

Sprite blocks;
Sprite clouds;
StopWatch sw = new StopWatch();

public void setup() {
  size(640, 480);
  bg = loadImage("bg1.jpg");
  int dayMode = 3;
  
  smooth();
  frameRate(30);
  
  yPos=178; xPos=187; 

  blocks = new Sprite(this, "spritesheet.png", 2, 1, 99);
  blocks.setXY(270, 250);
  blocks.setFrameSequence(0, 1, 0.5f);

  clouds = new Sprite(this, "clouds.png", 4, 1, 99);
  clouds.setXY(width/2, 85);
  clouds.setFrameSequence(0, 3, 0.5f);

  minim = new Minim(this);
  playerN = minim.loadFile("n.mp3");
  playerBg = minim.loadFile("bg.mp3");
  playerBg.loop();
}

void draw() {
  background(0);
  
  println(dayMode);
  switch(dayMode)
  {
    case 1:
    {
      tint(68, 100, 94);
      break;
    }
    default:
    {
      noTint();
    }
  }
  
  image(bg, width/2, height/2);
  
  //myRobot(185, 175);
  myRobot(xPos, yPos);

  float elapsedTime = (float) sw.getElapsedTime();
  clouds.update(elapsedTime);
  clouds.draw();
  
}

void keyPressed() 
{
  if (key == CODED) 
  {
    if (keyCode == LEFT) 
    {
      xPos = xPos-10;
      println("left");
    } else if (keyCode == RIGHT) 
    {
      xPos = xPos+10;
      println("right");
    } else if (keyCode == UP) 
    {
      yPos = yPos-10;
      println("up");
    } else if (keyCode == DOWN) 
    {
      yPos = yPos+10;
      println("down");
    }
  }
  
  if(key == 'n')
  {
   dayMode = 1; //night mode 
   playN();
   playerBg.mute();
   tint(68, 100, 94);
  // nRobot = loadImage("nrobot.png");
  // nRobot(187, 177);
   eyeSide= true;
  } 
  else if(key == 'd')
  {
    dayMode = 3; //day
    playerBg.play(1);
    playerN.mute();
  }
}

void keyReleased() {

  if (key== '-') mute();
  if (key== '=') unmute();
}

void playN()
{
  stopAll();
  playerN.play(1);
}

void playBg()
{
  stopAll();
  playerBg.play(1);
}

void mute()
{
  playerBg.mute();
}

void unmute()
{
  playerBg.unmute();
}

void stopAll()
{
  if(playerBg.isPlaying()){playerN.pause();}
  if(playerN.isPlaying()){playerBg.pause();}
}

void myRobot(int x, int y) {
  rectMode(CENTER);
  pushMatrix();
  //translate(-250, -150);
  translate(x, y);

  //big yellow body//
  fill(255, 255, 113);
  rect(80, 146, 100, 216);

  //green hair//
  fill(19, 155, 0);
  ellipse(81, 13, 26, 26); 
  ellipse(68, 36, 26, 26);
  ellipse(95, 36, 26, 26);

  //eyes//
  pushMatrix();
  fill(255, 255, 255);
  rect(47, 84, 56, 56);
  rect(80, 83, 10, 3);
  rect(113, 84, 56, 56);
  fill(86, 86, 86);
  if(eyeSide)
  {
    ellipse(65, 97, 13, 13);
    ellipse(123, 97, 13, 13);
  }
  else
  {
    ellipse(57, 97, 13, 13);
    ellipse(100, 97, 13, 13);
  }
  popMatrix();

  //mouth//
  fill(219, 143, 137);
  if(mouthA)
  {
    rect(80, 1, 31, 8);
  } 
  else 
  {
    rect(80, 128, 31, 31);
  }
  

  //teeth//
  fill(255, 255, 255);
  rect(74, 116, 8, 8);
  rect(85, 116, 8, 8);

  //clothes - light blue//
  fill(0, 229, 223);
  rect(17, 195, 27, 43);
  rect(144, 195, 27, 43);
  rect(80, 225, 100, 60);
  rect(66, 264, 31, 17);
  rect(97, 264, 31, 17);

  //clothes - dark blue//
  fill(0, 90, 145);
  rect(17, 214, 27, 5);
  rect(144, 214, 27, 5);
  rect(80, 193, 100, 5);
  rect(66, 269, 31, 6);
  rect(97, 269, 31, 6);

  //neck tie - bottom//
  fill(255, 113, 113);
  triangle(69, 255, 80, 201, 91, 255);

  //neck tie - top//
  fill(208, 190, 229);
  triangle(57, 195, 102, 195, 80, 219);
  
  float elapsedTime = (float) sw.getElapsedTime();
  blocks.update(elapsedTime);
  blocks.draw();
  popMatrix();
}

void nRobot(int x, int y) {
  rectMode(CENTER);
  pushMatrix();
  //translate(-250, -150);
  translate(x, y);

  //big yellow body//
  fill(255, 255, 113);
  rect(80, 146, 100, 216);

  //green hair//
  fill(19, 155, 0);
  ellipse(81, 13, 26, 26); 
  ellipse(68, 36, 26, 26);
  ellipse(95, 36, 26, 26);

  //eyes//
  pushMatrix();
  fill(255, 255, 255);
  rect(47, 84, 56, 56);
  rect(80, 83, 10, 3);
  rect(113, 84, 56, 56);
  fill(86, 86, 86);
  ellipse(65, 97, 13, 13);
  ellipse(120, 97, 13, 13);
  popMatrix();

  //mouth//
  fill(219, 143, 137);
  rect(80, 128, 31, 31);

  //teeth//
  fill(255, 255, 255);
  rect(74, 116, 8, 8);
  rect(85, 116, 8, 8);

  //clothes - light blue//
  fill(0, 229, 223);
  rect(17, 195, 27, 43);
  rect(144, 195, 27, 43);
  rect(80, 225, 100, 60);
  rect(66, 264, 31, 17);
  rect(97, 264, 31, 17);

  //clothes - dark blue//
  fill(0, 90, 145);
  rect(17, 214, 27, 5);
  rect(144, 214, 27, 5);
  rect(80, 193, 100, 5);
  rect(66, 269, 31, 6);
  rect(97, 269, 31, 6);

  //neck tie - bottom//
  fill(255, 113, 113);
  triangle(69, 255, 80, 201, 91, 255);

  //neck tie - top//
  fill(208, 190, 229);
  triangle(57, 195, 102, 195, 80, 219);

  popMatrix();
  
}

