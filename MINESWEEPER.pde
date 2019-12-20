grid grid[][] = new grid[10][10];
boolean firstclick = true;
boolean gameoverboo = false;
boolean flagmode = false;
void setup() {
  size(642, 692);  
  strokeWeight(2);
  stroke(0);
  noFill();
  textAlign(CENTER, CENTER);
  textSize(48);


  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j] = new empty(i, j);

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j].count();
}

void draw() {
  background(155);

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++) {
      grid[i][j].show();
    }

  fill(255);
  text("UI SPACE", width/4, 20);
  text("FLAG", (width/4)* 3, 20);
  if (mouseX > ((width/4)* 3)- 48 && mouseX < ((width/4)* 3)+ 48 && mouseY > 2 && mouseY < 30) {    //work on this, both are  triggiring at the same  time
    if (mousePressed && flagmode == false) {
      text("test123 -> true", width/2, height/2);
      flagmode = true;
    }
    if (mousePressed && flagmode == true) {
      text("test123 -> false", width/2, height/2);
      flagmode = false;
    }
  }
  if (gameoverboo == true) {
    gameover();
  }
}



void mouseClicked() { 
  if (mouseY>=50) {
    int i = int(map(mouseX, 0, width, 0, grid.length));
    int j = int(map(mouseY, 50, height, 0, grid.length));
    if (!grid[i][j].bomb) {
      if (firstclick) {
        firstcli(i, j);
      }
      if (grid[i][j].bombcount == 0 && flagmode == false) {
        clear(i, j);
      }
    } else if (flagmode == false) {
      gameoverboo = true;
    }
    System.out.print(i +" "+ j);
    grid[i][j].clicked=true;
  }
}


void firstcli(int x, int y) {
  grid[x][y].isempty = true;
  for (int i = 0; i<4; i++) {
    int nx = x;
    int ny = y;
    FloatList turn = new FloatList();
    for (int m = 0; m < 4; m++) {
      turn.append(PI*m/2);
    }    
    while (turn.size() > 0) {
      int valu = int(random(0, turn.size()));
      float val = turn.get(valu);
      nx += int(cos(val));
      ny += int(sin(val));
      grid[nx][ny].isempty = true; 
      turn.remove(valu);
    }
  }    
  for (int i = 0; i < bombcount; i++) {
    bombgenerate();
  }  
  for (int i = 0; i < grid.length; i++) {
    for (int j = 0; j < grid.length; j++) {
      grid[i][j].count();
    }
  } 
  firstclick = false;
}

void gameover() {
  background(0);
  fill(255);
  textSize(48);
  text("Game Over", width/2, (height/4));
  text("Exit", width/4, (height/2)-10);
  if (mouseX > (width/4)-48 && mouseX < (width/4)+48 && mouseY > ((height/2)-10)-24 && mouseY < ((height/2)-10)+24) {
    fill(155); 
    if (mousePressed) {
      exit();
    }
  }
  fill(255);
  text("Retry", (width/4)*3, (height/2)-10);
  if (mouseX > ((width/4)*3)-48 && mouseX < ((width/4)*3)+48 && mouseY > ((height/2)-10)-24 && mouseY < ((height/2)-10)+24) {
    fill(155); 
    if (mousePressed) {
      //Mouse input works. Still need to implement a game restart (reset all variables)
    }
  }
}

void clear(int x, int y) {
  if (grid[x][y].bombcount ==0 && !grid[x][y].bomb) {
    grid[x][y].checked = true;
    for (int i = 0; i<3; i++) {
      for (int j = 0; j < 3; j ++) {  
        grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].clicked= true;
        if (!grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].bomb && !grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].checked && grid[constrain(x+i-1, 0, 9)][constrain(y+j-1, 0, 9)].bombcount ==0) {          
          clear(constrain(x+i-1, 0, 9), constrain(y+j-1, 0, 9));
        }
      }
    }
  }
}
