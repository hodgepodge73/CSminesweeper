class grid {
  PVector reallocation, gridlocation;
  int fill;
  grid() {
  }

  void show() {
    fill(fill);
    square(reallocation.x, reallocation.y, 64);
  }
}

class flag extends grid {

  flag(float x, float y) {
    gridlocation = new PVector(x, y);
    reallocation = new PVector(64*x, 64*y+50);
    fill = 255;
  }
}

class bomb extends grid {

  bomb(float x, float y) {
    gridlocation = new PVector(x, y);
    reallocation = new PVector(64*x, 64*y+50);
    fill = 0;
  }
}

class empty extends grid {

  empty(float x, float y) {
    gridlocation = new PVector(x, y);
    reallocation = new PVector(64*x, 64*y+50);
    fill = 155;
  }
}
