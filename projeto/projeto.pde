final int POSITION_SHIFT = 10;
final static int numObstacles = 4;
final Obstacle[] obstacles = new Obstacle[numObstacles];

//posição inicial do jogador.
float PlayerxPos1, PlayerxPos2, PlayerxPos3;
boolean play = true; //se 'false' o jogo para.
int lives = 3;

// Background
PImage background;

// Textos
PFont f;
int level = 1;
int numObstaclesGone = 0;

class Obstacle {
  float xPos;
  float yPos;
  boolean canWalk;
  boolean canShow;

  Obstacle() {
    xPos    = random(700);
    yPos    = 0;
    canWalk = true;
    canShow = false;
  }
  
  void display(){
    if(random(100) > 99) {
      canShow = true;
      numObstaclesGone++;
    }
    
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
          yPos += 2 * level;
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
    } //<>//
    
    return false;
  }
}

void setup() {
  // Tela Inicial
  f = createFont("Georgia", 16, true);
  play = false;
  
  background = loadImage("images/background.png");
  size(700, 700);
  background(background);
  
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
  background(background); 
  triangle(PlayerxPos1, 690, PlayerxPos2, 600, PlayerxPos3, 690);
  
  if (!play) {
    textFont(f, 24);
    textAlign(CENTER);
    fill(255);
    if (lives == 3) {
      text("Pressione <enter> para iniciar o jogo!", 700/2, 700/2);
    } else if (lives > 0) {
      text("Você perdeu uma vida, pressione <enter> para iniciar o jogo novamente", 45, 700/2, 600, 600);
    } else {
      text("GAME OVER", 700/2, 700/2);
    }
  } else {
    text("Level: " + level, 600, 28);
    if (numObstaclesGone > 100){
      level++;
      numObstaclesGone = 0;
    }
  }
  
  //mostra a quatidade de vidas do jogador.
  for(int i = 1; i <= lives; i++){
    int aux = (20 * i);
    triangle(10+aux, 30, 20+aux, 10, 30+aux, 30);
  }
  
  for(int i = 0; i < obstacles.length; i++){
    if (play){
      obstacles[i].display();
      obstacles[i].walk();
      
      if(obstacles[i].checkColision()){
        play = false;
        lives--;
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
  } else {
    if (keyCode == ENTER) {
      play = true;
      for(int i = 0; i < numObstacles; i++){
        Obstacle obs = new Obstacle();
        obstacles[i] = obs;
      }
    }
  }
}