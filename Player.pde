
class Player {
  int posX; int posY;
  final int SIZE_X; final int SIZE_Y;
  color objectColor = color(255);
  int previousPosX;
  
  Player(int marginY) {
    posX = WIN_X/2;
    posY = WIN_Y - marginY;
    previousPosX = posX;
    
    SIZE_X = 100;
    SIZE_Y = 20;
  }
  void move(int inputX) {
    previousPosX = posX;
    if (inputX > SIZE_X/2 && inputX < WIN_X - SIZE_X/2) posX = inputX-SIZE_X/2;
  }
    
  void draw() {
    noStroke();
    fill(objectColor);
    rect(posX, posY, SIZE_X, SIZE_Y);
  }
}
