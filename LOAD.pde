boolean loaded;
GUI GUI[] = new GUI[1];

void load() { 
  restart();
  GUI[0] = new GUItogglebutton(0, (width/4)* 3-100, 0, (width/4)* 3+100, 50, "FLAG", 0, 0, 255, 0, 25, 255, true);

  loaded = true;
}

void restart() {
  firstclick = true;
  gameoverboo = false;


  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j] = new empty(i, j);

  for (int i = 0; i < grid.length; i++)
    for (int j = 0; j < grid.length; j++)
      grid[i][j].count();
}
