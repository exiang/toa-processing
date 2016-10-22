int robot;
int x=0;
int y=0;
PImage bgImage, doorImage, lampImage, black;
boolean blackBG = true;

//music 
import ddf.minim.*;

Minim minim;
AudioPlayer playerBg, playerS, playerM, playerD;

//sprite sheet
import sprites.utils.*;
import sprites.maths.*;
import sprites.*;

Sprite eyes;
Sprite tri;
Sprite tri2;
Sprite tri3;
Sprite tri4;
Sprite tri5;
Sprite tri6;
Sprite tri7;
Sprite tea;
StopWatch sw = new StopWatch();

void setup()
{
 size(640,480); 
 bgImage= loadImage("data/bg0.jpg");
  
  //images
   doorImage = loadImage("data/door.png");
   lampImage = loadImage("data/lamp.png");
   black = loadImage("data/black-bg.png");
  
  
  //sprite sheet
  eyes = new Sprite(this,"data/eyes.png", 3, 1, 99);
  eyes.setXY(width/3,height/3);
  eyes.setFrameSequence(0,3,0.3f);
  
  
  //sprite sheet triangle rotate
  tri = new Sprite(this,"data/flyd.png", 9, 1, 99);
  tri.setXY(50,40);
  tri.setFrameSequence(0,9,0.1f);
  
  tri2 = new Sprite(this,"data/flyd.png", 9, 1, 99);
  tri2.setXY(140,40);
  tri2.setFrameSequence(0,9,0.1f);
  
  tri3 = new Sprite(this,"data/flyd.png", 9, 1, 99);
  tri3.setXY(230,40);
  tri3.setFrameSequence(0,9,0.1f);
  
  tri4 = new Sprite(this,"data/flyd.png", 9, 1, 99);
  tri4.setXY(320,40);
  tri4.setFrameSequence(0,9,0.1f);
  
  tri5 = new Sprite(this,"data/flyd.png", 9, 1, 99);
  tri5.setXY(410,40);
  tri5.setFrameSequence(0,9,0.1f);
  
  tri6 = new Sprite(this,"data/flyd.png", 9, 1, 99);
  tri6.setXY(500,40);
  tri6.setFrameSequence(0,9,0.1f);
  
  tri7 = new Sprite(this,"data/flyd.png", 9, 1, 99);
  tri7.setXY(590,40);
  tri7.setFrameSequence(0,9,0.1f);
  
  //Sprite tea
  tea = new Sprite(this,"data/tea.png", 6, 1, 99);
  tea.setXY(175,353);
  tea.setFrameSequence(0,6,0.4f);
  
  
  //music
  minim = new Minim(this);
  
  //-specialMusic-//
  playerS = minim.loadFile("data/b.mp3");
  
  //-bgMusic-//
  playerBg = minim.loadFile("data/a.mp3");
  playerBg.loop();
  
  //-meow-//
  playerM = minim.loadFile("data/m.mp3");

  //ding//
  playerD = minim.loadFile("data/ding.mp3");
}



void draw()
{
  background(bgImage);
  image(doorImage,570,266);
  image(lampImage,150,125);
  

  
  pushMatrix();
 float elapsedTime = (float) sw.getElapsedTime();
  tri.update(elapsedTime);
  tri.draw();
  tri2.update(elapsedTime);
  tri2.draw();
  tri3.update(elapsedTime);
  tri3.draw();
  tri4.update(elapsedTime);
  tri4.draw();
  tri5.update(elapsedTime);
  tri5.draw();
  tri6.update(elapsedTime);
  tri6.draw();
  tri7.update(elapsedTime);
  tri7.draw();
  
  tea.update(elapsedTime);
  tea.draw();
  popMatrix();
  
  pushMatrix();
  scale(0.5);
  translate(mouseX,500);
  myRobot(); 
  
  pushMatrix();
  translate(90,0);
  //translate(x,y);
  //sprite sheet
  
  eyes.update(elapsedTime);
  eyes.draw();
  popMatrix();
  popMatrix();
  
  if(blackBG) image(black,320,240);

}

///////////////ninja
void myRobot()
{ 
  //left hand
 fill(58,58,58);
 noStroke();
 rect(220, 230, 17.999, 115.318);
 
 //right hand
 fill(58,58,58);
 noStroke();
 smooth();
 rect(375, 230, 17.999, 115.318);
 
 //left leg
 fill(58,58,58);
 noStroke();
 smooth();
 rect(250, 300, 17.999, 115.318);
 
 //right leg
 fill(58,58,58);
 noStroke();
 rect(340, 300, 17.999, 115.318);
 
  
  //head
 fill(0,0,0); 
 noStroke();
 smooth();
 ellipse(303.591,201.092,245.988, 245.988 );
 
 //eyes
  fill(58,58,58);
 noStroke();
 smooth();
 ellipse(303.591, 157.983, 167.792, 86.218);
 
// //left eyes
// fill(255,255,255);
// noStroke();
// smooth();
// ellipse(267.769,157.983,20.999,20.999);
// 
// //right eyes
// fill(255,255,255);
// noStroke();
// smooth();
// ellipse(339.561, 157.983, 20.999, 20.999);
 
}


/////////////////////////////////music
void keyReleased() {
  if (key == 's' || key == 'S') {playS();}
  else if (key == 'b' || key == 'B') {playB();}
  
  if(key=='-') mute();
  if(key=='=') unmute();
}

//mute&unmute music
void mute()
{
  playerBg.mute();
}
void unmute()
{
  playerBg.unmute();
}

//play BGM
void playB()
{
  stopAll();
  playerBg.play(1);
}

void playS()
{
  stopAll();
  playerS.play(1);
}

void stopAll()
{
  if(playerS.isPlaying()){playerS.pause(); playerS.rewind();}
}


//meow sound when door open 
void playM()
{
 stopAll();
 playerM.play(1); 
}

void stopM()
{
  playerM.pause(); 
}

void playD()
{
 stopAll();
 playerD.play(1); 
}


//hold mouseclick
 void mousePressed(){
   //mouseX value & mouseY value for specific area
   if(mouseX>300 && mouseX <640 && mouseY>70 && mouseY <450){
    doorImage = loadImage("data/door2.png");
    playM(); 
   }
  }
  
  
  
//release mouseclick
  void mouseReleased(){
    doorImage = loadImage("data/door.png");
    stopM(); 
  }
  
 
//mouseclick for lamp
  void mouseClicked(){
    if(mouseX>90 && mouseX<210 && mouseY>105 && mouseY<180){
      blackBG = !blackBG;
      playD();
    }
  }

