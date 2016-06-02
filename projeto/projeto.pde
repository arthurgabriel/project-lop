final int POSITION_SHIFT = 10;
final PShape[] obstacles = new PShape[4];

float xPos1, xPos2, xPos3;


void setup() {
  size(700, 700);
  background(155);
  
  //player
  xPos1 = 300;
  xPos2 = 700.0/2;
  xPos3 = 400;
  
  addTheObstacles();
}

void draw() {
  background(155);
  triangle(xPos1, 690, xPos2, 600, xPos3, 690);
  //for(int i = 0; i < obstacles.length; i++){
  // obstacleWalk(obstacles[i]);
  //}
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

// faz com que o obstáculo ande pela tela;
// se reposicione quando sai de vista;
// volte a sua borda de origem em um local diferente;
// só volte a andar depois de um certo tempo.
void obstacleWalk(PShape obstacle){
  PVector v = obstacle.getVertex(0);
  if(v.y == 755){  
    v.x = random(700);
    v.y = -55;
    obstacle.setVertex(0, v);
  } else {
    v.y += 1;
    obstacle.setVertex(0, v);
  }  
}

void addTheObstacles(){
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i] = createShape(ELLIPSE, random(700), 0, 55, 55);
    
    if(i == 0)
      obstacles[i].setFill(color(255,0,0));
    else if (i == 1)
      obstacles[i].setFill(color(0,0,255));
    else if (i == 2)
      obstacles[i].setFill(color(0,255,0));
    else
      obstacles[i].setFill(color(255,0,0));
      
    shape(obstacles[i]);
  }
}