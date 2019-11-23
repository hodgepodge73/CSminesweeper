class grid {
  PVector reallocation, gridlocation;
  int fill;

  boolean flagged, bomb;
  int bombcount;
  grid() {
    flagged = false;
    bombcount = 0;
  }

  void show() {
    fill(fill);
    square(reallocation.x, reallocation.y, 64);
    fill(0);
    if (this.bombcount != 0)
      text(""+bombcount, reallocation.x+32, reallocation.y+32);
  }

  void count() {
  }
}

int bombcount = 30;
class bomb extends grid {

  bomb(float x, float y) {
    gridlocation = new PVector(x, y);
    reallocation = new PVector(64*x, 64*y+50);
    fill = 0;
    bomb = true;
  }
}

class empty extends grid {

  empty(float x, float y) {
    gridlocation = new PVector(x, y);
    reallocation = new PVector(64*x, 64*y+50);
    fill = 155;
    bomb = false;
  }

  void count () {
    this.bombcount = 0;
    for ( int j = 0; j <3; j++)
      for (int i = 0; i < 3; i++)
        //if (gridlocation.x > 0 && gridlocation.y > 0 && gridlocation.x < grid.length -1 && gridlocation.y < grid.length - 1)
        if (grid[constrain(int(gridlocation.x + constrain(i - 1, -1, 1)), 0, 9)][constrain(int(gridlocation.y + constrain(j -1, -1, 1)), 0, 9)].bomb)
          if (gridlocation.x + constrain(i - 1, -1, 1) != -1 && gridlocation.x + constrain(i - 1, -1, 1) != 10)
            if (gridlocation.y + constrain(j - 1, -1, 1) != -1 && gridlocation.y + constrain(j - 1, -1, 1) != 10)
              this.bombcount++;
  }
}


void bombgenerate() {
  PVector random = new PVector((int)random(grid.length), (int)random(grid.length));
  if (!grid[(int)random.x][(int)random.y].bomb)
    grid[(int)random.x][(int)random.y] = new bomb(random.x, random.y);
  else
    bombgenerate();
}
