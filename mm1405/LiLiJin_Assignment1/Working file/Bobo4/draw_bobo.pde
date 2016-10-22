//------------------------DRAW Robot----------------------------//
void myRobot(int x, int y) 
{   
  noStroke();
  scale(0.5, 0.5);
  translate(x, y);
  
  //head
  noStroke();
  fill(4,16,46);
  rect(52, 110, 290, 270, 30);
  strokeWeight(5);
  stroke(0);
  fill(mouseX,mouseY,200);
  rect(77, 140, 240, 220, 20);
  noStroke();
  fill(4,16,46);
  e1.update(mouseX, mouseY);
  e2.update(mouseX, mouseY);
  e1.display();
  e2.display();
  fill(4,16,46);
  rect(200, 290, 15, 50, 15);
 
 // neck & body
  fill(4,16,46);
  rect(183, 380, 37, 25);//neck
  rect(293, 410, 20, 20);//connection to hand
  rect(90, 410, 20, 20);
  rect(100, 400, 35, 40);//shoulder
  rect(268, 400, 35, 40);
  quad(110, 400, 290, 400, 278, 580, 124, 580);//body
  //quad(x1, y1, x2, y2, x3, y3, x4, y4)
  
  drawLeftArm();
  drawRightArm();
  
  //connection to leg
  rect(157, 600, 30, 15);
  rect(220, 600, 30, 15);
  //jj
  rect(183, 578, 40, 40, 7);
  
  //leg
  rect(120, 590, 40, 120, 10);
  rect(250, 590, 40, 120, 10);
  
  fill(207, 247, 238);
  star(240, 530, 15, 30, 5); 
  fill(0);
  rect(130, 420, 70, 10);//deco
  rect(135, 435, 60, 10);//deco
  rect(140, 450, 50, 10);//deco
}

void star(float x, float y, float radius1, float radius2, int npoints) 
{
  float angle = TWO_PI / npoints;
  float halfAngle = angle/2.0;
  beginShape();
  for (float a = 0; a < TWO_PI; a += angle) {
    float sx = x + cos(a) * radius2;
    float sy = y + sin(a) * radius2;
    vertex(sx, sy);
    sx = x + cos(a+halfAngle) * radius1;
    sy = y + sin(a+halfAngle) * radius1;
    vertex(sx, sy);
  }
  endShape(CLOSE);
}
//------------------------END DRAW Robot----------------------------//

void drawLeftArm()
{
  fill(4,16,46);
  pushMatrix();
  translate(77, 400);
  //rotate(radians(135));
  //rotate(radians(armAngle));
  rotate(leftArmAngle);
  rect(-12, 0, 30, 250, 10);
  popMatrix();
}

void drawRightArm()
{
  fill(4,16,46);
  pushMatrix();
  translate(310, 400);
  //rotate(radians(135));
  //rotate(radians(-armAngle));
  rotate(rightArmAngle);
  rect(0, 0, 30, 250, 10);
  popMatrix();
}

//----------------------------eyes-------------------------------//
class Eye {
  int x, y;
  int size;
  float angle = 0.0;
  
  Eye(int tx, int ty, int ts) {
    x = tx;
    y = ty;
    size = ts;
 }

  void update(int mx, int my) {
    angle = atan2(my-y, mx-x);
  }
  
  void display() {
    pushMatrix();
    translate(x, y);
    fill(1, 23, 14);
    ellipse(0, 0, size, size);
    rotate(angle);
    fill(229, 255, 244);
    ellipse(size/4, 0, size/2, size/2);
    popMatrix();
  }
}
//----------------------------END eyes-------------------------------//

void radio()
{
 fill(37);
 rect(540,180,90,41); 
 rect(610,150,2,30);
 ellipse(611,150,5,5);
 fill(0);
 rect(550,195,50,4);
 rect(550,200,50,4);
 rect(550,205,50,4);
 //button
 fill(255,0,0);
 //rect(610,195,10,15);
 rect(button_x, button_y, button_sz, button_sq);
  if (play)
    player.play();
    else
    player.pause();
    
  if( mouseX>button_x && mouseX<button_x+button_sz && mouseY>button_y && mouseY<button_y+button_sq ) { 
    fill(127);
     
  } else {  
    fill(255,0,0);
  }
   

}

void table()
{
  fill(0);
  rect(500,220,170,10);  
  rect(520,230,130,70);
  rect(520,230,20,90);
  fill(255);
  rect(540,265,100,2);
  ellipse(595,250,10,10);
  ellipse(595,280,10,10);
}

void door()
{
 fill(255);
 rect(45,40,210,150);
 fill(200);
 rect(50,45,200,140);
 fill(255);
 rect(150,45,5,140);
 ellipse(125,120,10,10);
 ellipse(175,120,10,10);
 
 
}

