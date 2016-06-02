final int POSITION_SHIFT = 6;

float xPos1, xPos2, xPos3;
float xCirclePos, yCirclePos;
boolean flag = false;
boolean canWalk = true;

void setup() {
  size(700, 700);
  background(155);
  
  //player
  xPos1 = 300;
  xPos2 = 700.0/2;
  xPos3 = 400;
  
  //obstacle
  xCirclePos = random(700);
  yCirclePos = 0;
}

void draw() {
  background(155);
  triangle(xPos1, 690, xPos2, 600, xPos3, 690);
  ellipse(xCirclePos, yCirclePos, 55, 55);
  
    obstacleWalk();
}

void keyPressed() {
  if (keyCode == RIGHT) {
    if (xPos3 == 700)
      return;
      
    xPos1 += POSITION_SHIFT;
    xPos2 += POSITION_SHIFT;
    xPos3 += POSITION_SHIFT;
  } else if (keyCode == LEFT) {
    if (xPos1 == 0)
      return;
    
    xPos1 -= POSITION_SHIFT;
    xPos2 -= POSITION_SHIFT;
    xPos3 -= POSITION_SHIFT;
  }
}

void obstacleWalk(){
  if(yCirclePos == 755){
    yCirclePos = -55;
    canWalk = false;
  } else if(canWalk)
    yCirclePos++;
  else {
    float randomNumber = random(100);
    if (randomNumber > 99){
      xCirclePos = random(700);
      canWalk = true; 
    } 
  }  
}