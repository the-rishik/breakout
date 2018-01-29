//// location of ball
float x, y;
float ballDiameter = 10.0;
// velocity of ball
float dx, dy;
// location of bat
float batX;
// number of lives
int lives = 3;

int brickX, brickY;
int brickLength = 50;
int brickHeight = 20;

boolean[][] blocks = new boolean[500][200];

float previousX, previousY;

void setup() {  
  size(500, 500, P2D);
  frameRate(250);
  resetBall();
  background(0);
  batX = (width / 2) - 50;
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 11; j++) {
      blocks[i][j] = true;
    }
  }
}

void resetBall() { 
  x = width/2;  
  y = height/2;  
  dx = random(-1, 1);
  dy = random(0, 1);
}

void draw() {

  ballBat();
  background(0);
  drawBrick();
  ellipse(x, y, 10, 10);      

  previousX = x;
  previousY = y;
  x = x + dx;  
  y = y + dy;

  rect(batX, height - 10, 50, 10);
  if (keyCode == 37) { 
    batX -= 3;
    if (batX < 0) {
      batX = 0;
    }
  }

  if (keyCode == 39) {
    batX += 3;
    if (batX > (width - 50)) {
      batX = width - 50;
    }
  }

  if (x > width)
    dx = -dx;

  if (x < 0)
    dx = -dx;

  if (y > height)
  {   
    lives -= 1;
    if (lives == 0)
      endGame();
    else
      resetBall();
  }

  if (y < 0)
    dy = -dy;

  fill(255);
  textSize(20);
  text("Lives: " +lives, 0, 300);
}

void drawBrick() { 
  for (int i = 0; i < 11; i++) {
    for (int j = 0; j < 11; j++) {
      if (blocks[i][j])
      {
        brickX = i*50;
        brickY = j*20;

        rect(brickX, brickY, brickLength, brickHeight);


        if (y > brickY && y < brickY + brickHeight && y > brickY - brickHeight && x + ballDiameter/2 > brickX && x - ballDiameter/2 < brickX + brickLength && blocks[(int)x/50][(int)y/20]) {
          if (previousX < brickX || previousX > brickX + brickLength) {
            dx = -dx;
            blocks[(int)x/50][(int)y/20] = false;
          }
          if ( previousY < brickY || previousY > brickY + brickHeight)
          {
            dy = -dy;
            blocks[(int)x/50][(int)y/20] = false;
          }
        }
      }
    }
  }
}

void keyPressed() {  
  if (key == 's') {    
    save("breakout.png");
  }
}

void endGame() {
  exit();
}
void keyReleased() {
  keyCode = -1;
}

void ballBat() {
  if (x > batX && x < batX + 50) {
    if (y > height-10) {
      dy = -dy;
    }
  }
}