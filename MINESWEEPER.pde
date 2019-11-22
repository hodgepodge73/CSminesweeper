grid grid[][] = new grid[10][10];

void setup() {
  size(642, 692);  
  strokeWeight(2);
  stroke(0);
  noFill();
  textAlign(CENTER, CENTER);
  textSize(48);

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      switch((int)random(3)) {
      case 0:
        grid[i][j] = new empty(i, j);
        break;
      case 1:
        grid[i][j] = new flag(i, j);
        break;
      case 2:
        grid[i][j] = new bomb(i, j);
        break;
      }
}

void draw() {
  background(155);

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++) {
      grid[i][j].show();
    }

  fill(255);
  text("UI SPACE", width/2, 20);
}
