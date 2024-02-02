final int WIN_X = 600;
final int WIN_Y = 800;

Player player;
Player computer;
Ball ball;

final int MAX_LIVES = 3;
final int BALL_SPEED_Y_RESET = 4;
final int BALL_SPEED_X_RESET = 1;

int ballSpeedX;
int ballSpeedY;

int computerPosX;
int computerSpeedX;
int computerLives;
int playerLives;

boolean playerWins;
boolean computerWins;
boolean pointOver;

int maxComputerSpeed;
int isPoint;

void settings() {
  size(WIN_X, WIN_Y);
}

void setup() {
  computer = new Player(WIN_Y-100);
  player = new Player(100);
  ball = new Ball(BALL_SPEED_Y_RESET, player, computer);

  ballSpeedX = BALL_SPEED_X_RESET;
  ballSpeedY = BALL_SPEED_Y_RESET;
  
  resetBallSpeed();
  
  textSize(80);
  
  computerPosX = int(WIN_X/2);
  computerSpeedX = 5;
  computerLives = MAX_LIVES;
  playerLives = MAX_LIVES;
  
  computerWins = false;
  playerWins = false;
  
  pointOver = true;
  
  isPoint = 0;
  
  maxComputerSpeed = ball.MAX_SPEED;
}

void draw() {
  if (playerWins || computerWins) {
    reset();
  } else {
    background(0);
    textSize(80);
    text(computerLives, 50, 200);
    text(playerLives, 50, WIN_Y-120);

    textSize(20);
    text("ball x speed: ", 10, 30);
    text("ball y speed: ", 10, 60);
    text(abs(ball.speedX), 115, 30);
    text(abs(ball.speedY), 115, 60);

    color(100);
    strokeWeight(3);
    stroke(255);
    line(0, WIN_Y/2, WIN_X, WIN_Y/2);

    ball.move();
    player.move(mouseX);
    computer.move(computerPosX);
    ball.draw();
    computer.draw();
    player.draw();
    
    checkPoints();
    moveComputer();
  }
}

void resetBallSpeed() {
  if (round(random(1)) == 1) ball.speedY = ballSpeedY;
  else ball.speedY = -ballSpeedY;
  if (round(random(1)) == 1) ball.speedX = ballSpeedX;
  else ball.speedX = -ballSpeedX;
}

void moveComputer() {
  if (ball.posX > computerPosX + computer.SIZE_X/2.5) computerPosX += min(computerSpeedX, ball.posX - (computerPosX + computer.SIZE_X/2.5));
  else if (ball.posX < computerPosX - computer.SIZE_X/2.5) computerPosX -= min(computerSpeedX, (computerPosX - computer.SIZE_X/2.5) - ball.posX);
  computerSpeedX = min(computerSpeedX, maxComputerSpeed);
}

void checkPoints() {
  isPoint = ball.checkPointCollision();

  if (isPoint != 0) {
    if (isPoint == 1) {
      computerLives -= 1;
      
      if (computerLives == 3){
        computerSpeedX = 7;
      }
      else if (computerLives == 2) {
        computerSpeedX = 24;
      }
      else if (computerLives == 1) {
        computerSpeedX = 35;
      }
      else if (computerLives == 0) {
        playerWins = true;
      }
      ball.ballStopped = true;
      pointOver = true;

    } else {
      playerLives -= 1; //<>//
      if (playerLives == 0) {
        computerWins = true;
      }
      ball.ballStopped = true;
      pointOver = true;
    } //<>//
    ball.posX = WIN_X/2;
    ball.posY = WIN_Y/2;
    //resetBallSpeed();
  }
}

void reset() {
  textSize(80);
  if (playerWins) {
    background(0, 200, 0);
    text("You win! :D", WIN_X/2-180, WIN_Y/2);
  } else {
    background(200, 0, 0);
    text("You lose! :(", WIN_X/2-180, WIN_Y/2);
  }
}

void mousePressed() {
  if (playerWins || computerWins) {
    playerWins = false;
    computerWins = false;
    playerLives = MAX_LIVES;
    computerLives = MAX_LIVES;
  
    ballSpeedX = BALL_SPEED_X_RESET;
    ballSpeedY = BALL_SPEED_Y_RESET;
    
    resetBallSpeed();
  } else if (pointOver) {
    if (computerLives == 3){ //<>//
      ballSpeedY = 4;
    }
    else if (computerLives == 2) {
      ballSpeedY = 6;
    }
    else if (computerLives == 1) {
      ballSpeedY = 8;
    }
    else if (computerLives == 0) {
      playerWins = true;
    }
    resetBallSpeed();
    ball.ballStopped = false;
    pointOver = false;
  }
    
}
