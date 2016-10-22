PImage back, middle, front;
PVector vback, vmiddle, vfront;
int xPos, yPos = 0;

void setup()
{
  size(640,480);
  back = loadImage("bg.jpg");
  vback = new PVector(0, 0);
}


void paraDraw(PImage img, PVector pos, float vel)
{
  pos.sub(vel, 0, 0);
   
  int r = (int)pos.x+img.width;
 
  if(r < width) image(img, r, pos.y);
  if(pos.x < width) image(img, pos.x-img.width, pos.y); 
  if(pos.x < -img.width) pos.x = width;
  //println("r: " + r + ", pos.x: " +pos.x);
   
  image(img, pos.x, pos.y);
  //fill(#ff0000);
  //rect(pos.x, 0, img.width, img.height);
}

void draw()
{
  background(255);
  paraDraw(back, vback, 1);
  yPos = 240;
  myrobot(xPos, yPos);
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
}

void myrobot(int x, int y)
{ 
  pushMatrix();
    translate(-320, -240);
    translate(x, y);
    scale(2);
    
    //head
    fill(0,0,0);//black
    noStroke();
    rect(130, 100, 70, 70, 7);
    
    //power
    fill(255,200,200);//pink
    ellipse(160, 110, 3, 3);
    fill(127,0,0);//darkred
    ellipse(160, 118, 3, 3);
    ellipse(160, 126, 3, 3);
    fill(255,0,0);
    ellipse(170, 110, 3, 3);
    ellipse(170, 118, 3, 3);
    fill(127,0,0);
    ellipse(170, 126, 3, 3);
    
    //head.control
    fill(0,0,0);//black
    rect(161, 87, 7, 20);
    ellipse(155, 86, 20, 20);
    ellipse(175, 86, 20, 20);
    fill(255);//white
    ellipse(175, 86, 15, 15);
    ellipse(155, 86, 15, 15);
    
    
    
    
    
    //left ear
    fill(0,0,0);//black
    ellipse(130, 135, 30, 30);
    fill(255);//white
    ellipse(122, 135, 5, 5);
    
    rect(129, 120, 1, 30, 7);
    //left.wire
    fill(0,0,0);//black
    rect(125, 75, 2, 50);
    
    //right ear
    fill(0,0,0);//black
    ellipse(200, 135, 30, 30);
    fill(255);//white
    ellipse(208, 135, 5, 5);
    rect(200, 120, 1, 30, 7);
    rect(129, 120, 1, 30, 7);
    
    //right.wire
    fill(0,0,0);//black
    rect(203, 75, 2, 50);
    
    //eye.left
    fill(255);
    ellipse(145, 148, 12, 12);
    
    //eye.right
    fill(255);//white
    ellipse(185, 148, 12, 12);
    
    //mouth
    fill(255);//white
    rect(160, 154, 10, 2);
    rect(160, 157, 10, 2);
    
    rect(130, 163, 69, 1);
    
    //neck
    fill(0,0,0);//black
    rect(150, 171, 30, 5, 2);
    //body
    rect(150, 177, 30, 20, 2);
    
    //screen.body
    fill(255);//white
    rect(155, 181, 15, 10);
    fill(255,200,200);
    ellipse(175, 183, 3, 3);
    fill(127,0,0);//darkred
    ellipse(175, 188, 3, 3);
    
    //leg.left
    fill(0,0,0);//black
    rect(115, 198, 45, 5, 2);
    //leg.right
    rect(170, 198, 45, 5, 2);
    
    
    //right.hand
    fill(0,0,0);//black
    rect(182, 175, 4, 20);
    
    //left hand
    rect(127, 175, 20, 4);
    rect(123, 172, 4, 10);
    rect(115, 172, 10, 3);
    rect(115, 179, 10, 3);
    
    //square.rotate
    fill(255);//white
    rect(140, 108, 5, 5);
    rect(140, 116, 5, 5);
    rect(140, 124, 5, 5);
    
    //square.rotate.right
    fill(255);//white
    rect(185, 108, 5, 5);
    rect(185, 116, 5, 5);
    rect(185, 124, 5, 5);
    
   popMatrix();

 }
