PImage bgImage,a,potImage1,ghostImage1,ghostImage2,satayImage;
boolean lockImage = true;
boolean potImage = true;
boolean ghostImage = true;
boolean ghost2Image = true;
boolean satay2Image= true;

int xPos, yPos = 0;
import sprites.utils.*;
import sprites.maths.*;
import sprites.*;
import ddf.minim.*;
Minim minim;
AudioPlayer background;

Sprite star,star1,star2,star3,star4,star5,star6,star7,star8,star9,star10,star11,pot,ghost1,ghost2,satay2;


StopWatch sw = new StopWatch();
Eye e1;
Eye e2;
float x;
float y;


int armAngle = 0;
int angleChange = 3;
final int ANGLE_LIMIT = 20;


void setup()
{
  size(640,480);
  bgImage= loadImage("data/bg.jpg");
  
  //images
  
  a = loadImage("57.png");
  potImage1 = loadImage("data/pot3.PNG");
  ghostImage1 = loadImage("data/ghost.PNG");
  ghostImage2 = loadImage("data/ghost2.PNG");
//  satayImage =  loadImage("data/satay.png");
  frameRate(30);
  
  //starrrrrr
  star = new Sprite(this, "data/star1.png", 11, 1, 1);
  star.setXY(150, 250);
  star.setFrameSequence(0, 10, 0.1f);
  
  star2 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star2.setXY(50, 50);
  star2.setFrameSequence(0, 10, 0.2f);

  star3 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star3.setXY(70, 280);
  star3.setFrameSequence(0, 10, 0.3f);

  star4 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star4.setXY(60, 290);
  star4.setFrameSequence(0, 10, 0.15f);

  star5 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star5.setXY(50, 150);
  star5.setFrameSequence(0, 10, 0.2f);

  star6 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star6.setXY(350, 40);
  star6.setFrameSequence(0, 10, 0.4f);

  star7 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star7.setXY(480, 190);
  star7.setFrameSequence(0, 10, 0.1f);
  
  star8 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star8.setXY(230, 270);
  star8.setFrameSequence(0, 10, 0.1f);

  star9 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star9.setXY(580, 200);
  star9.setFrameSequence(0, 10, 0.2f);

  star10 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star10.setXY(550, 210);
  star10.setFrameSequence(0, 10, 0.5f);

  star11 = new Sprite(this, "data/star1.png", 11, 1, 1);
  star11.setXY(430, 300);
  star11.setFrameSequence(0, 10, 0.2f);  
  
  pot = new Sprite(this, "data/potmeat.png", 17, 1, 1);
  pot.setXY(510, 325);
  pot.setFrameSequence(0, 17, 0.15f);
  
  ghost1 = new Sprite(this, "data/ghost1.png", 11, 1, 1);
  ghost1.setXY(196, 268);
  ghost1.setFrameSequence(0, 11, 0.2f);
  
  ghost2 = new Sprite(this, "data/ghost3.PNG", 8, 1, 1);
  ghost2.setXY(410, 44);
  ghost2.setFrameSequence(0, 11, 0.2f);
  
  satay2= new Sprite(this, "data/satay2.png", 5, 1, 1);
  satay2.setXY(350, 340);
  satay2.setFrameSequence(0, 11, 0.2f);

  noStroke();
  e1 = new Eye( 145,  148,  20);
  e2 = new Eye( 185,  148,  20);
  smooth();

   minim = new Minim(this);
   background= minim.loadFile("data/background.mp3");
   background.loop();


  
}


void draw()
{
  background(bgImage);
  //images
  
  
  
  
  float elapsedTime = (float) sw.getElapsedTime();
  star.update(elapsedTime);
  star.draw();
  star2.update(elapsedTime);
  star2.draw();
  star3.update(elapsedTime);
  star3.draw();
  star4.update(elapsedTime);
  star4.draw();
  star5.update(elapsedTime);
  star5.draw();
  star6.update(elapsedTime);
  star6.draw();
 
  star8.update(elapsedTime);
  star8.draw();
  star9.update(elapsedTime);
  star9.draw();

  pot.update(elapsedTime);
  pot.draw();
  ghost1.update(elapsedTime);
  ghost1.draw();
  ghost2.update(elapsedTime);
  ghost2.draw();

 
  float mX;
  float mY;
  
  pushMatrix();
  armAngle += angleChange;
  if (armAngle > ANGLE_LIMIT || armAngle < 0)
  {
    angleChange = -angleChange;
    armAngle += angleChange;
  }
  popMatrix();

    satay2.update(elapsedTime);
  satay2.draw();
  if (potImage)  image(potImage1, 522,346);  // or set(0, 0, a);
  if (ghostImage)  image(ghostImage1, 197,250);  // or set(0, 0, a);
  if (ghost2Image)  image(ghostImage2, 420,42);  // or set(0, 0, a);
//  if (satay2Image)  image(satayImage,335,338);  // or set(0, 0, a);
  yPos = 240;
  myrobot(xPos, yPos);
  star7.update(elapsedTime);
  star7.draw(); 
  star11.update(elapsedTime);
  star11.draw();
  star10.update(elapsedTime);
  star10.draw();
  
  
  
  
  if (lockImage)  image(a, 320, 240);  // or set(0, 0, a);
     
  //mouse
    x = lerp(x, mouseX, 0.3);
    y = lerp(y, mouseY, 0.3);
    
    fill(255);
    ellipse(x, y, 6, 6);
  

   
}


class Eye 
{
  int ex, ey;
  int size;
  float angle = 0.0;
  Eye(int x, int y, int s) 
  {
    ex = x;
    ey = y;
    size = s;
  }

  void update(int mx, int my) 
  {
    angle = atan2(my-ey, mx-ex);
  }

  void display() {
    pushMatrix();
      translate(ex, ey);
      fill(0);
      ellipse(0, 0, size, size);
      rotate(angle);
      fill(255);
      ellipse(size/4, 0, size/2, size/2);
    popMatrix();

  }

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
  }
  if(key == 'a'){
    lockImage = false;
  }
  else if(key == 'b'){
        lockImage = true;
  }

}

void myrobot(int x, int y)
{ 
  pushMatrix();
    translate(120, -90);
    translate(x, y);
    scale(1.2);
    
    //head
    fill(255);//black
    noStroke();
    rect(120, 100, 90, 70, 25);
    fill(255,200,200);
    ellipse(135, 156, 15, 15);
    ellipse(195, 156, 15, 15);
   
    //head.control
    fill(255);//black
    rect(161, 87, 7, 20);
    ellipse(155, 86, 20, 20);
    ellipse(175, 86, 20, 20);
    fill(255,200,200);//white
    ellipse(175, 86, 15, 15);
    ellipse(155, 86, 15, 15);
    
        
    
    e1.update(mouseX, mouseY);
    e1.display();
    
    e2.update(mouseX, mouseY);
    e2.display();

    
    //mouth
    fill(0);//white
    rect(157, 154, 15, 4,10);

    //body
    fill(255);//white
    rect(150, 167, 30, 30, 2);
    
    
    //leg.left
    fill(255);//white
    rect(155, 195, 5, 15, 2);
    //leg.right
    rect(170, 195, 5, 15, 2);
    
   
    

    drawLeftArm();
    drawRightArm();
   popMatrix();

 }
 
 
void drawLeftArm()
{
  pushMatrix();
  fill(255);
  translate(145, 174);
  rotate(radians(armAngle));
  rect(0, 0, 5, 20,3); // left arm
  popMatrix();
}

void drawRightArm()
{
  pushMatrix();
  fill(255);
  translate(182, 174);
  rotate(radians(-armAngle));
  rect(0, 0, 5, 20,3); // right arm

  popMatrix();
}

//hold mouseclick
// void mousePressed(){
//   potImage = !potImage;
//   ghostImage = !ghostImage;
//  }

 void mousePressed(){
   //mouseX value & mouseY value for specific area
   if(mouseX>500 && mouseX <640 && mouseY>380 && mouseY <450){
    potImage = !potImage;
   }
   if(mouseX>100 && mouseX <240 && mouseY>00 && mouseY <290){
    ghostImage=!ghostImage;
   }
   
   if(mouseX>400 && mouseX <500 && mouseY>00 && mouseY <50){
    ghost2Image=!ghost2Image;
   }
//   if(mouseX>300 && mouseX <450 && mouseY>350 && mouseY <490){
//    satay2Image=!satay2Image;
//   }
   
  }


