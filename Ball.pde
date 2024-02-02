class Ball {
  int posX; int posY;
  float speedX; float speedY;
  float speedDecrease;
  final int DIAMETER;
  final int MAX_SPEED;
  final int MIN_SPEED;
  final int MAX_ADDED_SPEED;
  color objectColor = color(255);
  
  boolean insideObject;
  boolean bottomObject;
  
  boolean ballStopped;
  
  Ball(int inputSpeed, Player inputPlayer, Player inputComputer) {
    DIAMETER = 30;
    speedX = 1;
    speedY = inputSpeed;
    
    posX = WIN_X/2;
    posY = WIN_Y/2;
    
    speedDecrease = 0.01;
    
    MAX_ADDED_SPEED = 10;
    MAX_SPEED = 20;
    MIN_SPEED = 1;
    
    insideObject = false;
    bottomObject = false;
    
    ballStopped = true;
    
    player = inputPlayer;
    computer = inputComputer;
  }
  
  float distance(float x1, float y1, float x2, float y2) {
    return sqrt(((x1 + x2)*(x1 + x2)) + ((y1 + y2)*(y1 + y2)));
  }
  
  float angle(float x1, float y1, float x2, float y2) {
    float o = distance(x1, y1, x1, y2);
    float h = distance(x1, y1, x2, y2);
    return sin(o/h);
  }
  
  void checkWinCollision() {
    if (posX + speedX + DIAMETER/2 > WIN_X) {
      speedX *= -1;
      if (posX + speedX + DIAMETER/2 > WIN_X) posX += WIN_X - (posX + speedX + DIAMETER/2);
    }
    if (posX + speedX - DIAMETER/2 < 0) {
      speedX *= -1;
      if (posX + speedX - DIAMETER/2 < 0) posX += 0 - (posX + speedX - DIAMETER/2);
    }
  }
  
  int checkPointCollision() {
    if (posY + speedY + DIAMETER/2 > WIN_Y) return 2;
    else if (posY + speedY - DIAMETER/2 < 0) return 1;
    else return 0;
  }
  
  void checkPlayerCollision(Player inputPlayer) {
    if ((posX + speedX + DIAMETER/2 > inputPlayer.posX && posX + speedX - DIAMETER/2 < inputPlayer.posX + inputPlayer.SIZE_X) &&
    (posY + speedY + DIAMETER/2 > inputPlayer.posY && posY + speedY - DIAMETER/2 < inputPlayer.posY + inputPlayer.SIZE_Y)) {
      if (!insideObject) {
        speedY *= -1;

        float playerMove = inputPlayer.posX - inputPlayer.previousPosX;
        if (playerMove == 0) {
          speedX *= 1;
        } else if (playerMove > 0) {
          playerMove = min(MAX_ADDED_SPEED, playerMove);
          if (speedX + playerMove < MAX_SPEED) speedX += playerMove;
          speedX = max(speedX, MIN_SPEED);
        } else {
          playerMove = max(-MAX_ADDED_SPEED, playerMove);
          if (speedX + playerMove > -MAX_SPEED) speedX += playerMove;
          speedX = min(speedX, -MIN_SPEED);
        }
      }
      insideObject = true;
      if (posY > WIN_Y/2) {
        bottomObject = true;
      }
      else bottomObject = false;
    } 
    if (bottomObject && posY < WIN_Y/2) insideObject = false;
    if (!bottomObject && posY > WIN_Y/2) insideObject = false;
  }
  
  void move() {
    checkWinCollision();
    checkPlayerCollision(player);
    checkPlayerCollision(computer);
    if (!ballStopped) {
      posX += round(speedX);
      posY += round(speedY);
      if (speedX > MIN_SPEED || speedX < -MIN_SPEED) {
        if (speedX > 0) speedX -= speedDecrease;
        else speedX += speedDecrease;
      }
    }
  }
  
  void draw() {
    noStroke();
    fill(objectColor);
    circle(posX, posY, DIAMETER);
  }
}
