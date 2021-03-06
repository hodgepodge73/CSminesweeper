class grid {
  PVector reallocation, gridlocation;
  int fill;
  //list of booleans
  boolean revealed = false, flagged, bomb;
  boolean checked = false;
  boolean clicked = false, cleared = false, isempty=false;
  
  int bombcount;
  grid() {
    flagged = false;
    bombcount = 0;
  }

  void show() {
    fill(155);
    square(reallocation.x, reallocation.y, 64);
    //Ethan
    if (!clicked) {
      image(tile, reallocation.x, reallocation.y);
      if (flagged) {
        imageMode(CENTER);
        image(flag, reallocation.x+32, reallocation.y+32);
        imageMode(CORNER);
      }
    } else {
      if (flagged)
        flagged = false;
      fill(0);
      if (this.bombcount != 0 && clicked && !flagged)
        text(""+bombcount, reallocation.x+32, reallocation.y+32);
    }
  }

  void count() {
  }
}

int bombcount = 30; //amount of bombs in generation

//grid classes by Aidan
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
  //Ethan
  //Counts bombs around it
  void count () {
    this.bombcount = 0;
    for ( int j = 0; j <3; j++)
      for (int i = 0; i < 3; i++)        
        if (grid[constrain(int(gridlocation.x + i - 1), 0, 9)][constrain(int(gridlocation.y + j -1), 0, 9)].bomb)
          if (gridlocation.x + i - 1 != -1 && gridlocation.x + i - 1 != 10)
            if (gridlocation.y + j - 1 != -1 && gridlocation.y + j - 1 != 10)
              this.bombcount++;
  }
}

//Aidan
//generates new bombfield
void bombgenerate() {
  PVector random = new PVector((int)random(grid.length), (int)random(grid.length));
  if (!grid[(int)random.x][(int)random.y].bomb && !grid[(int)random.x][(int)random.y].isempty)
    if (canputbomb(int(random.x), int(random.y))) {
      grid[(int)random.x][(int)random.y] = new bomb(random.x, random.y);
    } else
      bombgenerate();
}
// Ethan
// checks if it can put bomb in a specific spot
boolean canputbomb(int x, int y) {
  boolean can = true;
  for (int i =0; i <3; i++)
    for (int j = 0; j<3; j++)
      if (grid[constrain(x-1+i, 0, 9)][constrain(y-1+j, 0, 9)].isempty || grid[x][y].isempty) {
        can = false;
      }
  return can;
}
