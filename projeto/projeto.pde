final int POSITION_SHIFT = 10;
final static int numObstacles = 4;
final Obstacle[] obstacles = new Obstacle[numObstacles];

//posição inicial do jogador.
float PlayerxPos1, PlayerxPos2, PlayerxPos3;
boolean play = true; //se 'false' o jogo para.
int lifes = 3;

class Obstacle {
  float xPos;
  float yPos;
  boolean canWalk;
  boolean canShow;

  Obstacle() {
    xPos   = random(700);
    yPos = 0;
    canWalk = true;
    canShow = false;
  }
  
  void display(){
    if(random(100) > 99)
      canShow = true;
    
    if(canShow)
      ellipse(xPos, yPos, 55, 55);  
  }
  
  void walk(){
    if(canShow){
      if(yPos >= 755){  
        xPos = random(700);
        yPos = -55;
        canWalk = false;
      } else {
        if(canWalk)
          yPos += 2;
        else{
          if(random(100) > 99)
            canWalk = true;
        }
      }
    }
  }
  
  boolean checkColision(){
    if((yPos + 27.5) >= 600 && (yPos - 27.5) <= 690){
      float altura = yPos - 600;
      double baseMenorTrapezio = ((PlayerxPos3 - PlayerxPos2)/90) * altura * 2;
      double aux =  (PlayerxPos3 - (PlayerxPos1 + baseMenorTrapezio))/2;
      if(((xPos + 32) >= (PlayerxPos1 + aux) && (xPos - 32) <= (PlayerxPos3 - aux)))
        return true;
    }
    return false;  
  }
}

void setup() {
  size(700, 700);
  background(155);
  
  //posição iniciao do jogador
  PlayerxPos1 = 300;
  PlayerxPos2 = 700.0/2;
  PlayerxPos3 = 400;
  
  for(int i = 0; i < numObstacles; i++){
    Obstacle obs = new Obstacle();
    obstacles[i] = obs;
  }
}

void draw() {
  background(155);
  triangle(PlayerxPos1, 690, PlayerxPos2, 600, PlayerxPos3, 690);
  
  //mostra a quatidade de vidas do jogador.
  for(int i = 1; i <= lifes; i++){
    int aux = (20 * i);
    triangle(10+aux, 30, 20+aux, 10, 30+aux, 30);
  }
  
  for(int i = 0; i < obstacles.length; i++){
    obstacles[i].display();
    if (play){
      obstacles[i].walk();
      
      if(obstacles[i].checkColision()){
        play = false;
        lifes--;  
      }
    }
  }
}

void keyPressed() {
  if (play) {
    if (keyCode == RIGHT) {
      if (PlayerxPos3 == 700)
        return;
        
      PlayerxPos1 += POSITION_SHIFT;
      PlayerxPos2 += POSITION_SHIFT;
      PlayerxPos3 += POSITION_SHIFT;
    } else if (keyCode == LEFT) {
      if (PlayerxPos1 == 0)
        return;
      
      PlayerxPos1 -= POSITION_SHIFT;
      PlayerxPos2 -= POSITION_SHIFT;
      PlayerxPos3 -= POSITION_SHIFT;
    }
  }
}