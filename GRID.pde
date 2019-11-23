class grid {
  PVector reallocation, gridlocation;
  boolean bomb = false;
  int fill;
  int bombcount = 0;
  grid() {
  }
  void count(){
    
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
    bomb = true;
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
  void count (){
    super.count();
    for ( int j = 0; j <3; j++){
      for (int i = 0; i < 3; i++){
        //if (gridlocation.x > 0 && gridlocation.y > 0 && gridlocation.x < grid.length -1 && gridlocation.y < grid.length - 1)
          if (grid[constrain(int(gridlocation.x + constrain(i - 1, -1, 1)), 0, 9)][constrain(int(gridlocation.y + constrain(j -1, -1, 1)), 0 , 9)].bomb){
            if (gridlocation.x + constrain(i - 1, -1, 1) != -1 && gridlocation.x + constrain(i - 1, -1, 1) != 10){
              if (gridlocation.y + constrain(j - 1, -1, 1) != -1 && gridlocation.y + constrain(j - 1, -1, 1) != 10){
                bombcount++;
              }
            }  
          }
       }
    }
  }
  void show(){
    super.show();
    if (bombcount>0){
      fill(0);
      textSize(14);
      text(bombcount, reallocation.x + 32, reallocation.y + 32);
      textSize(48);
    }
  }
}
